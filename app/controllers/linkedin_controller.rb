class LinkedinController < ApplicationController

  def index
    url = URI(get_authorize_url)
    @authorize_url = "#{url.scheme}://#{url.host}#{url.path}"
    @oauth_token = url.query.split('=')[1]
    @callback = "http://#{request.host}:#{request.port}/auth/linkedin/callback"
    @linkedins = Rails.cache.fetch('linkedin', :expires_in => 23.hours) do
      Linkedin.where(published: true).limit(100).order('followers_count DESC')
    end
    @title = "Les #{@linkedins.size} freelances francophones les plus suivis sur LinkedIn"
    @tab = 'linkedin'
    respond_to do |format|
      format.html
      format.json {
        render :json => @linkedins
      }
    end
  end

  def create

    if(!session[:rtoken] || !session[:rsecret])
      respond_to action: 'index'
    end

    begin
      client = LinkedIn::Client.new(ENV['linkedin_client_id'], ENV['linkedin_client_secret'])
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], params[:oauth_verifier])
    rescue Exception
      return render :status => 200
    end

    if !client
      return render :status => 200
    end

    update_or_create(client)
  end

  def update
    users = Linkedin.all()
    users.each do |user|
      if user.published
        sync_es(user)
      end
    end
  end

  protected

  def get_authorize_url
    client_id = ENV['linkedin_client_id']
    client_secret = ENV['linkedin_client_secret']
    client = LinkedIn::Client.new(client_id, client_secret)
    request_token = client.request_token(:oauth_callback => "http://#{request.host}:#{request.port}/auth/linkedin/callback", :scope => "r_basicprofile,r_emailaddress")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
    return request_token.authorize_url
  end

  def update_or_create(user)
    linkedin = Linkedin.find_by linkedin_id: user.profile.id
    if !linkedin
      linkedin = Linkedin.create(:linkedin_id => user.profile.id)
      linkedin.published = false
      linkedin.rank = 0
      linkedin.linkedin_id = user.profile.id
    end
    linkedin.bio = user.profile.headline
    linkedin.first_name = user.profile.first_name
    linkedin.last_name = user.profile.last_name
    linkedin.location = user.profile(:fields => %w(location)).location.name
    linkedin.email = user.profile(:fields => %w(email-address)).email_address
    linkedin.avatar_url = user.picture_urls(:id => user.profile.id).all[0]
    linkedin.followers_count = user.profile(:fields => %w(num-connections)).num_connections
    linkedin.num_connections_capped = user.profile(:fields => %w(num-connections-capped)).num_connections_capped
    linkedin.linkedin_url = user.profile(:fields => %w(public-profile-url)).public_profile_url
    linkedin.save
  end

  def sync_es(linkedin)
    client = Elasticsearch::Client.new host: ENV['SEARCHBOX_URL']
    response = client.search index: 'influencers', body: { min_score: 1.5, query: { match: { email: linkedin.email } } }
    result = Hashie::Mash.new response
    if result.hits.total > 0
      user = result.hits.hits[0]._source
    else
      user = {}
      user[:email] = linkedin.email
    end
    #if linkedin.respond_to?(:location) and linkedin.location and "france".casecmp(linkedin.location) != 0
    #  location = Geocoder.coordinates(linkedin.location)
    #  user[:location] = location.join(',') if location
    #end
    user[:name] = "#{linkedin.first_name} #{linkedin.last_name}"
    user[:linkedin] = linkedin

    if result.hits.total > 0
      client.index  index: 'influencers', type: 'influencer', id: result.hits.hits[0]._id ,body: user
    else
      client.index  index: 'influencers', type: 'influencer', body: user
    end

  end
end

class DribbblersController < ApplicationController

  def index

    @dribblers = Rails.cache.fetch('dribblers', :expires_in => 23.hours) do
      Dribbler.where(rank: 1).order('followers DESC')
    end

    @title = "Les #{@dribblers.size} freelances francophones les plus suivis sur Dribbble"
    @tab = 'dribbblers'
    respond_to do |format|
      format.html
      format.json {
        render :json => @dribblers
      }
    end
  end

  def create
    client = Dribbble::Client.new token: ENV['dribbble_token']

    user = client.get_user(params[:pseudo])
    if !user
      render :status => 200
    end
    update_or_create(user, 0, params[:pseudo])
  end

  def update
    dribbblers = Dribbler.all()
    client = Dribbble::Client.new token: ENV['dribbble_token']
    dribbblers.each do |dribbbler|
      begin
        #user = client.get_user(dribbbler.username)
        #if user
        #update_or_create(user, dribbbler.rank, dribbbler.username)
        #end
        if dribbbler.rank == 1
          sync_es(dribbbler)
        end
      rescue Exception => e
        puts "dribbble error => #{dribbbler.username}"
        puts e.message  
        puts e.backtrace.inspect
      end
    end
  end

  protected

  def update_or_create(user, rank, pseudo)

    dribbler = Dribbler.find_by username: pseudo
    if !dribbler
      dribbler = Dribbler.create(:username => pseudo)
      dribbler.rank = 0
    end
    dribbler.picture = user.avatar_url
    dribbler.bio = user.bio
    dribbler.username = user.username
    dribbler.name = user.name
    dribbler.location = user.location
    dribbler.followers = user.followers_count
    dribbler.save
    if dribbler.rank == 1
      sync_es(dribbler)
    end
  end

  def sync_es(dribbler)
    client = Elasticsearch::Client.new host: ENV['SEARCHBOX_URL']
    response = client.search index: 'influencers', body: { min_score: 2, query: { match: { pseudo: dribbler.username } } }
    result =  Hashie::Mash.new response
    if result.hits.total > 0
      user = result.hits.hits[0]._source
    else
      response = client.search index: 'influencers', body: { min_score: 2, query: { match: { name: dribbler.name } } }
      result = Hashie::Mash.new response
      if result.hits.total > 0
        user = result.hits.hits[0]._source
      else
        user = {}
        user[:pseudo] = dribbler.username
      end
    end
    #if dribbler.respond_to?(:location) and dribbler.location and "france".casecmp(dribbler.location) != 0
    #  location = Geocoder.coordinates(dribbler.location)
    #  user[:location] = location.join(',') if location
    #end
    user[:name] = dribbler.name
    user[:dribbbler] = dribbler

    if result.hits.total > 0
      client.index  index: 'influencers', type: 'influencer', id: result.hits.hits[0]._id ,body: user
    else
      client.index  index: 'influencers', type: 'influencer', body: user
    end

  end

end

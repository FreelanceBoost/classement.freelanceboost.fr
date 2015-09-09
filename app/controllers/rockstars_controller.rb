require 'date'
class RockstarsController < ApplicationController

  def index

      @tab = 'rockstars'
      @rockstars = Rails.cache.fetch('rockstars', :expires_in => 23.hours) do
        Rockstar.where(rank: 1).order('follower_count DESC')
      end
      @title = "Les #{@rockstars.size} freelances francophones les plus suivis sur Twitter"
      respond_to do |format|
        format.html
        format.json {
          render :json => @rockstars
        }
      end
  end

  def create
    client = twlient()

    begin
      user = client.user(params[:pseudo])
      if !user
        render :status => 200
      end
    rescue Exception
      return render :status => 200
    end

    update_or_create(user, 0, params[:pseudo])
  end

  def update
    rockstars = Rockstar.all()
    client = twlient()
    today = Date.today
    rockstars = rockstars[rockstars.size / 2, rockstars.size-1] if today.mday % 2 == 0
    rockstars = rockstars[0, rockstars.size / 2] if today.mday % 2 != 0
    rockstars.each do |rockstar|
      begin
        user = client.user(rockstar.pseudo)
        if user
          update_or_create(user, rockstar.rank, rockstar.pseudo)
        end
      rescue Exception => e
        puts "twitter error => #{rockstar.pseudo}"
        puts e.message  
        puts e.backtrace.inspect
      end
    end
  end

  protected

  def twlient
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = ENV['twitter_access_token']
      config.access_token_secret = ENV['twitter_access_token_secret']
   end
    client
  end

  def update_or_create(user, rank, pseudo)
    @follower_count = user.followers_count
    @tweet_count = user.tweets_count
    @friends_count = user.friends_count
    @img_url = user.profile_image_url_https.to_str
    @img_url["_normal"] = "_bigger"
    @description = user.description
    @listed_count = user.listed_count
    @screen_name = user.screen_name
    @name = user.name
    @location = user.location
    @verified = user.verified

    pseudo = pseudo.gsub('@','')
    rockstar = Rockstar.find_by pseudo: pseudo
    if !rockstar
      rockstar = Rockstar.create(:pseudo => pseudo)
      rockstar.rank = 0
    end
    rockstar.url_img = @img_url
    rockstar.desc = user.description
    rockstar.name = user.name
    rockstar.location = user.location
    rockstar.follower_count = user.followers_count
    rockstar.save
    if rockstar.rank == 1
      sync_es(rockstar)
    end
  end

  def sync_es(rockstar)
    client = Elasticsearch::Client.new host: ENV['SEARCHBOX_URL']
    response = client.search index: 'influencers', body: { query: { match: { pseudo: rockstar.pseudo } } }
    result = Hashie::Mash.new response
    if result.hits.total > 0
      user = result.hits.hits[0]._source
    else
      response = client.search index: 'influencers', body: { query: { match: { name: rockstar.name } } }
      result = Hashie::Mash.new response
      if result.hits.total > 0
        user = result.hits.hits[0]._source
      else
        user = {}
        user[:pseudo] = rockstar.pseudo
      end
    end
    #if rockstar.respond_to?(:location) and rockstar.location and "france".casecmp(rockstar.location) != 0
      #location = Geocoder.coordinates(rockstar.location)
      #user[:location] = location.join(',') if location
    #end
    if !user[:name]
      user[:name] = rockstar.name
    end
    user[:twitter] = rockstar

    if result.hits.total > 0
      client.index  index: 'influencers', type: 'influencer', id: result.hits.hits[0]._id ,body: user
    else
      client.index  index: 'influencers', type: 'influencer', body: user
    end

  end

end

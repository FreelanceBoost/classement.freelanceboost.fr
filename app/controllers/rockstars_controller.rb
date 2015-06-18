require 'date'
class RockstarsController < ApplicationController

  def index
      @title = "Les 200 freelances francophones les plus suivis sur Twitter"
      @tab = 'rockstars'
      @rockstars = Rails.cache.fetch('rockstars', :expires_in => 1.hours) do
        Rockstar.where(rank: 1).limit(200).order('follower_count DESC')
      end
      respond_to do |format|
        format.html
        format.json {
          render :json => @rockstars
        }
      end
  end

  def create
    client = twlient()

    user = client.user(params[:pseudo])
    if !user
      render :status => 200
    end
    update_or_create(user, 0, params[:pseudo])
  end

  def update
    rockstars = Rockstar.where(rank: 1).limit(200).order('follower_count DESC')
    client = twlient()
    today = Date.today
    rockstars = rockstars[100,199] if today.mday % 2 == 0
    rockstars = rockstars[0,99] if today.mday % 2 != 0
    rockstars.each do |rockstar|
      user = client.user(rockstar.pseudo)
      if user
        update_or_create(user, rockstar.rank, rockstar.pseudo)
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
  end

end
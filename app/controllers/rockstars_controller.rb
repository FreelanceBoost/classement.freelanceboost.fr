require 'date'
class RockstarsController < ApplicationController

  def index
      @rockstars = Rockstar.where(rank: 1).limit(100).order('follower_count DESC')
      respond_to do |format|
        format.html
        format.json {
          render :json => rockstars
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
    rockstars = Rockstar.where(rank: 1).limit(100).order('follower_count DESC') 
    client = twlient()
    today = Date.today
    rockstars = rockstars[50,0] if today.mday % 2 == 0
    rockstars = rockstars[0,50] if today.mday % 2 != 0
    rockstars.each do |rockstar|
      user = client.user(rockstar.pseudo)    
      if user
        update_or_create(user, rockstar.rank, rockstar.pseudo)
      end      
    end
    respond_to do |format|
        format.html
        format.json {
          render :json => {status: "ok"}, :status => 200
        }
    end    
  end

  protected

  def twlient 
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "tpUNsQuMvR1Lp3c469loTn6IR"
      config.consumer_secret     = "x5d898RLATY9skNE0JqOc2sE4TzD0w6hPDcz2RXLhcvZSTgTZr"
      config.access_token        = "92309068-BOTrYCjeogNSzqKTU3Rf0RqW6vq4DwPq9NF6oPJhU"
      config.access_token_secret = "JY4YO81dXLiPBFYWG2rVFm10HBUKr59e08cxT1v2P3FiV"
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
    @rank = rank

    pseudo = pseudo.gsub('@','')
    rockstar = Rockstar.find_by pseudo: pseudo
    if !rockstar
      rockstar = Rockstar.create(:pseudo => pseudo)
    end
    rockstar.rank = @rank
    rockstar.url_img = @img_url
    rockstar.desc = user.description
    rockstar.name = user.name
    rockstar.location = user.location
    rockstar.follower_count = user.followers_count
    rockstar.save
  end

end
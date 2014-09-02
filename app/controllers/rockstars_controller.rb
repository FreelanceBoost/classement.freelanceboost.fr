class RockstarsController < ApplicationController

  def index
      @rockstars = Rockstar.all.order('rank DESC')
  end
  
  def create
    
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "1oM199t4yf4Dq8fm2PCnQ"
      config.consumer_secret     = "CD4X3xIojSjUIw8AdDS8PklnHmZa6w6ZsVwaDNco"
      config.access_token        = "92309068-BOTrYCjeogNSzqKTU3Rf0RqW6vq4DwPq9NF6oPJhU"
      config.access_token_secret = "JY4YO81dXLiPBFYWG2rVFm10HBUKr59e08cxT1v2P3FiV"
    end

    user = client.user(params[:pseudo])
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
    @retweet_count = client.search("rt " + params[:pseudo]).count
    @rank = (@tweet_count + @listed_count * 2 + @follower_count * 2) / 5 - (@friends_count + @retweet_count * 2) / 3
    
    Rockstar.create(:pseudo => params[:pseudo], 
      :rank => @rank,
      :url_img => @img_url,
      :desc => user.description,
      :name => user.name,
      :location => user.location)
  end

end
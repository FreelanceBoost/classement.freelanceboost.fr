class RockstarsController < ApplicationController

  def index
      @rockstars = Rockstar.where('rank > -1').order('rank DESC')
  end
  
  def create
    
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "1oM199t4yf4Dq8fm2PCnQ"
      config.consumer_secret     = "CD4X3xIojSjUIw8AdDS8PklnHmZa6w6ZsVwaDNco"
      config.access_token        = "92309068-BOTrYCjeogNSzqKTU3Rf0RqW6vq4DwPq9NF6oPJhU"
      config.access_token_secret = "JY4YO81dXLiPBFYWG2rVFm10HBUKr59e08cxT1v2P3FiV"          
    end
    
    @follower_count = client.user(params[:pseudo]).followers_count
    
    rockstar = Rockstar.new(pseudo: params[:pseudo], rank: -1)
    rockstar.save
    @rockstars = Rockstar.all
  end      
  
end

class RockstarsController < ApplicationController

  def index
      @rockstars = Rockstar.where('rank > -1').order('rank DESC')
  end
  
  def create
    rockstar = Rockstar.new(pseudo: params[:pseudo], rank: -1)
    rockstar.save
    @rockstars = Rockstar.all
  end      
  
end

class RockstarsController < ApplicationController
  def index
      @rockstars = Rockstar.all.order('rank DESC')
  end
  
  def create
    Rockstar.new(pseudo: params[:pseudo]).save
    @rockstars = Rockstar.all
  end      
end

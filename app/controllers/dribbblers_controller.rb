class DribbblersController < ApplicationController

  def index
    @dribblers = Dribbler.where(rank: 1).limit(100).order('followers DESC')
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
  end

end

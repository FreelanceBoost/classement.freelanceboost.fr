class DribblersController < ApplicationController

  def index
    @dribblers = Dribbler.where(rank: 1).limit(100).order('followers DESC')
    @title = "Les #{@dribblers.size} freelances francophones les plus suivis sur Dribbble"
    respond_to do |format|
      format.html
      format.json {
        render :json => @dribblers
      }
    end
  end

  def create
    client = Dribbble::Client.new token: '8fee369206cb79bb6dec48ad2ff6c15ab2365763efc074bfc8629e7d5ac605b5'

    user = client.get_user(params[:pseudo])
    if !user
      render :status => 200
    end
    update_or_create(user, 0, params[:pseudo])
  end

  protected

  def update_or_create(user, rank, pseudo)

    dribbler = Dribbler.find_by name: pseudo
    if !dribbler
      dribbler = Dribbler.create(:name => pseudo)
    end
    dribbler.rank = rank
    dribbler.picture = user.avatar_url
    dribbler.bio = user.bio
    dribbler.username = user.username
    dribbler.name = user.name
    dribbler.location = user.location
    dribbler.followers = user.followers_count
    dribbler.save
  end

end

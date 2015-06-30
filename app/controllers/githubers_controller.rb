class GithubersController < ApplicationController

  def index
    @githubers = Githuber.where(published: true).limit(100).order('followers_count DESC')
    @title = "Les #{@githubers.size} freelances francophones les plus suivis sur GitHub"
    @tab = 'githubers'
    respond_to do |format|
      format.html
      format.json {
        render :json => @githubers
      }
    end
  end

  def create
    begin
      user = Github.users.get user:params[:login]
    rescue Exception
      return render :status => 200
    end
    if !user
      return render :status => 200
    end
    update_or_create(user, 0, params[:login])
  end

  def update
    githubers = Githuber.all()
    githubers.each do |githuber|
      user = Github.users.get user:githuber.github_login
      if user
        update_or_create(user, githuber.rank, githuber.github_login)
      end
    end
  end

  protected

  def update_or_create(user, rank, login)

    githuber = Githuber.find_by github_login: login
    if !githuber
      githuber = Githuber.create(:github_login => login)
      githuber.published = false
    end
    githuber.rank = rank
    if user.respond_to?(:bio)
      githuber.bio = user.bio
    end
    if user.respond_to?(:name)
      githuber.name = user.name
    end
    if user.respond_to?(:blog)
      githuber.blog = user.blog
    end
    if user.respond_to?(:email)
      githuber.email = user.email
    end
    if user.respond_to?(:company)
      githuber.company = user.company
    end
    if user.respond_to?(:location)
      githuber.location = user.location
    end
    if user.respond_to?(:hireable)
      githuber.hireable = user.hireable
    end
    githuber.avatar_url = user.avatar_url
    githuber.github_login = user.login
    githuber.followers_count = user.followers
    githuber.following_count = user.following
    githuber.github_type = user.type
    githuber.public_repo = user.public_repos
    githuber.public_gist = user.public_gists
    githuber.github_id = user.id
    githuber.github_updated_at = user.updated_at
    githuber.github_created_at = user.created_at
    githuber.githuburl = user.html_url

    githuber.save
  end

end

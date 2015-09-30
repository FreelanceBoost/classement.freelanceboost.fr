class RankingController < ApplicationController

  def index
      @tab = 'ranking'
      client = Elasticsearch::Client.new host: ENV['SEARCHBOX_URL']
      response = client.search index: 'influencers', body:
        {
          sort: [{ total_followers_count: {order: "desc"}}],
          from: 0,
          size: 300,
          query:
          {
            match_all: { }
          }
        }
      @allranking = Hashie::Mash.new response
      @title = "Le classement des freelances les plus influents sur le web"
      if params['share'] == 'true'
        @share = true
      end
      respond_to do |format|
        format.html
        format.json {
          render :json => @allranking.hits.hits
        }
      end
  end


  def all
      client = Elasticsearch::Client.new host: ENV['SEARCHBOX_URL']
      response = client.search index: 'influencers', body:
        {
          from: 0,
          size: 10000,
          query:
          {
            match_all: { }
          }
        }
      @allranking = Hashie::Mash.new response
      respond_to do |format|
        format.json {
          render :json => @allranking.hits.hits
        }
      end
  end

  def calculate_rank
    client = Elasticsearch::Client.new host: ENV['SEARCHBOX_URL']
      response = client.search index: 'influencers', body:
        {
          from: 0,
          size: 10000,
          query:
          {
            match_all: { }
          }
        }
      allranking = Hashie::Mash.new response

      allranking.hits.hits.each do |item|
        total_followers_count = 0
        if item._source.twitter
          total_followers_count += item._source.twitter.follower_count
        end
        if item._source.dribbbler
          total_followers_count += item._source.dribbbler.followers
        end
        if item._source.github
          total_followers_count += item._source.github.followers_count
        end
        if item._source.linkedin
          total_followers_count += item._source.linkedin.followers_count
        end

        item._source['total_followers_count']  = total_followers_count
        client.index  index: 'influencers', type: 'influencer', id: item._id, body: item._source

      end
  end

end

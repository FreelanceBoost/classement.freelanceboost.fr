class RankingController < ApplicationController

  def index
      @tab = 'ranking'
      #@rockstars = Rails.cache.fetch('allranking', :expires_in => 24.hours) do
        client = Elasticsearch::Client.new host: ENV['SEARCHBOX_URL']
        response = client.search index: 'influencers', body:
          {
            from: 0,
            size: 100,
            query:
            {
              match_all: { }
            }
          }
        @allranking = Hashie::Mash.new response
      #end
      @title = "Les #{@allranking.hits.total} freelances rockstars francophones !"
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
        if item._source.twitter
          total_followers_count += item._source.twitter.follower_count
        end
        if item._source.twitter
          total_followers_count += item._source.twitter.follower_count
        end

        puts "#{item._source.pseudo}=>#{total_followers_count}"
      end
  end

end

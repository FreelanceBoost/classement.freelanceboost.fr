class Linkedin < ActiveRecord::Base
  attr_accessible :rank, :published, :followers_count, :num_connections_capped
end

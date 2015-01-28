class Rockstar < ActiveRecord::Base
  attr_accessible :pseudo, :desc, :url_img, :rank, :name, :location, :good, :follower_count
end
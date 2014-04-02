class Rockstar < ActiveRecord::Base
  attr_accessible :pseudo, :desc, :url_img, :rank, :name
end
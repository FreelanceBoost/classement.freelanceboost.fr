require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module FreelanceboostRanking
  class Application < Rails::Application
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.cache_store = :dalli_store
    config.middleware.use Rack::Deflater
  end
end

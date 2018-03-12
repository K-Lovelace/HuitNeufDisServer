require_relative 'boot'

require 'rails/all'
require 'neo4j/railtie'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Picking
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.generators { |g| g.orm :neo4j }
    config.neo4j.session.type = :http
    config.neo4j.session.url = 'https://kimberly_blanda_cornsilk:oOjiqDfns6CRW4GoLFTqpZmvAeaJYalHWhJ7L1aE@kimberly-blanda-cornsilk.aws.graphstory.com:7473'
    config.notifications = {
      public_key: "BJxDQ20-VxC9M0rLCFDj3Bu75wHnYDZXKc_ZwLRtpBlzRFzclUIckZ3jKCaOTaUBruGe3LPHG3KKk3q0IRCWU1k=",
      private_key: "ziGR7LYnUFoIJOXcw5Hgvw760p9z7pp-A2K8DXRUvlM="
    }

    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

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
    config.neo4j.session.url = 'https://huitneufdis:b.0ixZbib7S5qZ.0sblEeOJht6zuWbT@hobby-fkiilamakgkigbkeildbdpal.dbs.graphenedb.com:24780/db/data/'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

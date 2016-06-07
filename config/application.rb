require File.expand_path("../boot", __FILE__)

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DreamlistApi
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.action_dispatch.default_headers = {
    'Access-Control-Allow-Origin' => '*',
    'Access-Control-Request-Method' => %w{GET POST PUT DELETE OPTIONS}.join(","),
    'Access-Control-Allow-Headers => 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  }
  end
end

require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Picgram
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.generators do |g|
      g.assets false
      g.helper false
      g.jbuilder false
    end
  end
end

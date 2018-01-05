require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
                 :headers => :any,
                 :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client', 'accept-language'],
                 :methods => [:get, :post, :options, :delete, :patch, :put]
      end
    end

    config.active_job.queue_adapter = :sidekiq

    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{*/}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'policies', '{*/}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'services')]
    config.autoload_paths += Dir[Rails.root.join('app', 'fetchers')]
    config.autoload_paths += Dir[Rails.root.join('lib')]

    # Logger
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.log_tags  = [:subdomain, :uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(logger)

    # Custom I18n fallbacks
    config.i18n.default_locale = :en

    config.after_initialize do
      I18n.fallbacks = I18n::Locale::Fallbacks.new(en: :'en_US')
    end

    # Sentry
    Raven.configure do |config|
      config.dsn = ENV['SENTRY_DNS']
    end
  end
end

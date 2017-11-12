require 'sidekiq/web'

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
  config.redis = { :size => 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
  config.redis = { :size => 9 }
end

unless Rails.env.development?
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [ENV['SIDEKIQ_WEB_USERNAME'], ENV['SIDEKIQ_WEB_PASSWORD']]
  end
end

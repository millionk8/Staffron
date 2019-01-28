Devise.setup do |config|
  config.secret_key = ENV['SECRET_KEY']
  config.mailer_sender = ENV['DEFAULT_FROM']
end
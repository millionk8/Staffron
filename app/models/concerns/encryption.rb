require 'active_support/concern'

module Encryption
  extend ActiveSupport::Concern

  def encryption_key
    if Rails.env.production?
      raise 'Must set secret key!!' unless ENV['SECRET_KEY']
      ENV['SECRET_KEY']
    else
      ENV['SECRET_KEY'] ? ENV['SECRET_KEY'] : 'test_key'
    end
  end

end
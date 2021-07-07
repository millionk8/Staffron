class Profile < ActiveRecord::Base
  include Encryption

  attr_encrypted :ssn, :key => :encryption_key

  # Associations
  belongs_to :user

  def full_name
    "#{first_name} #{last_name}"
  end
end
class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable

  # Associations
  belongs_to :company
  has_many :logs, as: :logger
  has_many :user_memberships, dependent: :destroy
  has_many :apps, through: :user_memberships
  has_one :profile, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :comments, foreign_key: 'author_id'

  # Methods
  def app_permissions(app_id)
    self.user_permissions.find_by(app_id: app_id).try(:permissions)
  end

  # Scopes
  scope :admin, -> { where(admin: true) }
  scope :employee, -> { where(admin: false) }

  accepts_nested_attributes_for :company
  accepts_nested_attributes_for :profile

end

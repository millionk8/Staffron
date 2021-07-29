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
  has_many :invoices, foreign_key: 'author_id'
  has_many :ptos
  has_many :time_logs
  
  scope :active, -> { where(deactivated: [false, nil]) }

  # Methods
  def permissions
    PermissionsManager.new(self).build_permissions
  end

  def destroy
    update_attributes(deactivated: true) unless deactivated
  end

  def active_for_authentication?
    super && !deactivated
  end

  def employment_years
    return 0.0 unless joining_date.present?
    
    ((Time.zone.now.to_date - joining_date) / 365 ).to_f.round(2)
  end  

  # Scopes
  # scope :admin, -> { where(admin: true) }
  # scope :employee, -> { where(admin: false) }

  accepts_nested_attributes_for :company
  accepts_nested_attributes_for :profile
end

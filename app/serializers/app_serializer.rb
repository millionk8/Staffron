class AppSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :machine_name,
             :version,
             :status

  attribute :settings, if: -> { current_user }

  has_many :packages
  has_many :roles

  has_many :app_memberships, if: -> { current_user && current_user.admin? } do
    object.app_memberships.where(company: scope.company, active: true)
  end

  has_many :user_memberships, if: -> { current_user && current_user.admin? } do
    object.user_memberships.where(company: scope.company)
  end

  def settings
    AppSettingsManager.new(object, current_user.company).build
  end
end

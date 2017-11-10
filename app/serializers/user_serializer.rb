class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :uuid,
             :email,
             :status,
             :master,
             :admin,
             :locale,
             :timezone,
             :apps

  belongs_to :company
  has_one :profile
  has_many :user_memberships

  def apps
    object.apps.ids
  end

end

class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :company_id,
             :uuid,
             :email,
             :status,
             :master,
             :admin,
             :locale,
             :policy_accepted_at,
             :employment_type,
             :joining_date,
             :remaining_pto_days,
             :remaining_sickness_days,
             :last_sign_in_at,
             :confirmed_at,
             :deactivated,
             :timezone,
             :permissions,
             :apps

  belongs_to :company
  has_one :profile
  has_many :user_memberships

  def apps
    object.apps.ids
  end

end

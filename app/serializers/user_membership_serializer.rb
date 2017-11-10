class UserMembershipSerializer < ActiveModel::Serializer
  attributes :id,
             :invitation_email,
             :invitation_sent_at,
             :invitation_expires_at,
             :invitation_accepted_at,
             :created_at,
             :updated_at

  attribute :app_id
  attribute :user_id
  attribute :role_id
  attribute :company_id

end

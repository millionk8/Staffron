class ProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :first_name,
             :last_name,
             :address,
             :address2,
             :city,
             :state,
             :zip,
             :phone,
             :title,
             :starting_date

  attribute :user_id

end

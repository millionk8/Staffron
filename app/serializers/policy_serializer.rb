class PolicySerializer < ActiveModel::Serializer
  attributes :id,
             :text,
             :company_id,
             :created_at,
             :updated_at

end

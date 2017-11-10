class RoleSerializer < ActiveModel::Serializer
  attributes :id,
             :app_id,
             :name,
             :machine_name

end

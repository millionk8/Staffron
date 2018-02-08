class LogSerializer < ActiveModel::Serializer
  attributes :id,
             :loggable_id,
             :loggable_type,
             :device_name,
             :browser_name,
             :os_name,
             :ip_address,
             :user_agent,
             :mobile,
             :tablet,
             :robot,
             :created_at

  attribute :action do
    Log.actions[object.action]
  end

  belongs_to :author

end

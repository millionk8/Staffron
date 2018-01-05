class ScheduleSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :day,
             :start_time,
             :work_length,
             :break_length,
             :created_at,
             :updated_at

  belongs_to :user

end

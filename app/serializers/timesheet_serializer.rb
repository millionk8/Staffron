class TimesheetSerializer < ActiveModel::Serializer
  attributes :id,
             :status,
             :week,
             :year,
             :note,
             :created_at,
             :updated_at

  belongs_to :user

end

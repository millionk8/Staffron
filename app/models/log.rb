class Log < ActiveRecord::Base

  enum action: [:invitation_accepted,
                :email_confirmed,
                :logged_in,
                :logged_out,
                :time_log_created,
                :time_log_started,
                :time_log_stopped,
                :time_log_updated,
                :time_log_deleted,
                :timesheet_submitted,
                :policy_accepted,
                :pto_created]

  # Associations
  belongs_to :author, class_name: 'User'
  belongs_to :loggable, polymorphic: true

end
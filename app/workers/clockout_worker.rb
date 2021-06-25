class ClockoutWorker
  include Sidekiq::Worker

  def perform(time_log_id)
    time_log = TimeLog.find(time_log_id)

    if time_log.stale?
       time_log.update_attribute(:stopped_at, Time.current)

       TimeLogMailer.delay.clock_out_email(time_log)
    end
  end
end
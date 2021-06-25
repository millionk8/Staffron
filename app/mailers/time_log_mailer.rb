class TimeLogMailer < ApplicationMailer
  def clock_out_email(time_log)
    @time_log = time_log

    mail(to: @time_log.user.email, subject: "Clocked Out")
  end
end
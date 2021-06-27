desc "Submit Timesheets"

namespace :timesheets do
  task submit: :environment do
    user_ids = TimeLog.where("DATE_PART('week', stopped_at) = ?", Date.today.cweek).pluck(:user_id).uniq

    user_ids.each do |user_id|
      Timesheet.find_or_create_by(user_id: user_id, week: Date.today.cweek, year: Date.today.year)
    end
  end
end
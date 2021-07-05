desc "Holidays"

namespace :holidays do
  task set: :environment do
    holidays = HolidaysService.new.call

    holidays.each do |holiday|
      HolidayCategory.create!(app_id: 1, company_id: 1, name: holiday['name'])
    end

    User.where(company_id: 1).each do |user|
      puts "User: #{user.id}"
      holidays.each do |holiday|
        category = HolidayCategory.where(name: holiday['name'], company_id: 1).first
        started_at = Time.zone.parse(holiday['date']['iso'])
        stopped_at = Time.zone.parse(holiday['date']['iso']).end_of_day
        
        time_log = TimeLog.create(user_id: user.id, 
          category_id: category.id, 
          started_at: started_at,
          stopped_at: stopped_at,
          actual_stopped_at: stopped_at,
          note: holiday['description']
        )
        puts "TimeLog: #{time_log.inspect}"
        puts time_log.errors.full_messages
      end
    end
  end
end
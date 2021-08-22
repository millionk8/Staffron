class PayrollService
  def initialize(company, from, to)
    @company = company
    @from = Date.strptime(from, "%m/%d/%Y").beginning_of_day
    @to = Date.strptime(to, "%m/%d/%Y").end_of_day
  end

  def call
    data = []

    @company.users.active.includes(:profile, time_logs: :category).where(time_logs: { started_at: @from..@to, deleted: false }).order("profiles.first_name ASC").each do |user|
      user_info = { name: user.profile.full_name, billing: 0.0, pto: 0.0, sickness: 0.0, holiday: 0.0, total: 0.0 }

      user.time_logs.each do |time_log|
        if time_log.category.is_a?(PtoCategory)
          hours = time_log.logged_days * 8.0
        elsif time_log.category.is_a?(HolidayCategory)
          hours = 8.0
        else
          hours = (time_log.stopped_at - time_log.started_at) / 1.hour
        end

        type = category_type(time_log.category).to_sym

        user_info[type] = user_info[type] + hours
        user_info[:total] = user_info[:total] + hours
      end
      user_info.transform_values! { |v| v.is_a?(Float) ? v.round(2) : v }

      data.push(user_info)
    end

    data
  end

  private

  def category_type(category)
    type = category.type.downcase.split('category')[0]

    if type == 'pto'
      category_name = category.name.downcase

      if category_name.include?('vacation')
      elsif category_name.include?('sickness')
        type = 'sickness'
      end
    end

    type
  end
  
end
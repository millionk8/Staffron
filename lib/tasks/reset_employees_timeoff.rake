desc "Reset Employees PTO/Sickness Days Yearly"

namespace :reset do
  task timeoff: :environment do
    User.active.where.not(employment_type: nil).all.each do |user|
      timeoff_days = if user.employment_type == 'half_time'
        TimeoffRules::PART_TIME
      else
        days_since_joined = Date.today - user.joining_date

        if user.employment_years < 1 && days_since_joined > 90
          TimeoffRules::FT_LT_1_YR
        elsif user.employment_years >= 1 && user.employment_years < 3
          TimeoffRules::FT_GTE_1_LT_3_YR
        else
          TimeoffRules::FT_GTE_3_YR
        end
      end

      user.update_columns(
        remaining_pto_days: timeoff_days[:pto],
        remaining_sickness_days: timeoff_days[:sickness]
      )
    end  
  end


  task current_year: :environment do
    User.includes(:ptos).active.where(ptos: { status: :approved }).where("DATE_PART('year', starts_at) = ?", Date.today.year).each do |user|
      offdays = { pto: 0.0, sickness: 0.0 }

      user.ptos.each do |pto|
        if pto.category.name.downcase == 'vacation'
          offdays[:pto] = offdays[:pto] + pto.requested_offdays
        else
          offdays[:sickness] = offdays[:sickness] + pto.requested_offdays
        end
      end

      user.update_columns(
        remaining_pto_days: user.remaining_pto_days - offdays[:pto],
        remaining_sickness_days: user.remaining_sickness_days - offdays[:sickness]
      )
    end
  end
end
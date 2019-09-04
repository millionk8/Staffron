class TimeLogPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:user).where('users.company_id = :company_id', company_id: user.company.id)
    end
  end

  def create?
    true
  end

  def update?
    !user.admin? && record.user == user
  end

  def start?
    !user.admin? && record.user == user
    # if ENV['ENABLE_SLACK']
    BespokeSlackbotService.new.timeclock_event('good', 'IN', user).deliver
    # end
  end

  def stop?
    !user.admin? && record.user == user
    # if ENV['ENABLE_SLACK']
    BespokeSlackbotService.new.timeclock_event('danger', 'OUT', user).deliver
    # end
  end

  def destroy?
    user.admin? && record.user == user
  end

end
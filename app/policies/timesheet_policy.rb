class TimesheetPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if @permissions.include?('can_manage_timesheets')
        scope.joins(:user).where('users.company_id = :company_id', company_id: user.company.id)
      else
        scope.where(user: user)
      end
    end
  end

  def show?
    user.company == record.user.company
  end

  def create?
    !user.admin?
  end

  def update?
    @permissions.include?('can_manage_timesheets') || record.user == user
  end

  def destroy?
    @permissions.include?('can_manage_timesheets')
  end
end
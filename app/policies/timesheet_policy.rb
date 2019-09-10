class TimesheetPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if @permissions.include?('admin') || @permissions.include?('manager') || @permissions.include?('officeAdmin')
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
    true
  end

  def update?
    @permissions.include?('admin') || @permissions.include?('manager') || @permissions.include?('officeAdmin') || record.user == user
  end

  def destroy?
    @permissions.include?('admin') || @permissions.include?('manager') || @permissions.include?('officeAdmin')
  end
end
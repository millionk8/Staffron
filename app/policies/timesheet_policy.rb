class TimesheetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
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
    user.admin? || record.user == user
  end

  def destroy?
    user.admin?
  end
end
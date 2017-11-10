class AppMembershipPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def destroy?
    user.admin? && user.company == record.company
  end
end
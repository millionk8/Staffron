class PolicyPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def accept?
    !user.admin? && record.company == user.company
  end
end
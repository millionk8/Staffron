class ProfilePolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def update?
    user.admin? || record.user == user
  end
end
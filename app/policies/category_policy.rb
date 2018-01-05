class CategoryPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def update?
    user.admin? && user.company == record.company
  end

  def set_default?
    user.admin? && user.company == record.company
  end

  def destroy?
    user.admin? && user.company == record.company
  end
end
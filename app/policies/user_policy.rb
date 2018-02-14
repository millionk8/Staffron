class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(company: user.company)
    end
  end

  def index?
    true
  end

  def show?
    user.admin?
  end

  def accept?
    !user.admin? && record.company == user.company
  end
end
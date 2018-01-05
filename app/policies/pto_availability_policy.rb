class PtoAvailabilityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.joins(:user).where('users.company_id = :company_id', company_id: user.company.id)
      else
        scope.where(user: user)
      end
    end
  end

  def index?
    true
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

end
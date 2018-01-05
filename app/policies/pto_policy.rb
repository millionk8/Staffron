class PtoPolicy < ApplicationPolicy
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
    user.admin? || record.user == user
  end

  def create?
    !user.admin?
  end

  def update?
    user.admin? || record.user == user
  end

  def destroy?
    user.admin? || record.user == user
  end
end
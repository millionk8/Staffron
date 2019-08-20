class CompanyPolicy < ApplicationPolicy

  def show?
    user.master? || user.admin? && user.company.id == record.id
  end

  def update?
    user.master? || user.admin? && user.company.id == record.id
  end

  def index?
    user.master?
  end

  def create?
    user.master?
  end

  def destroy?
    user.master?
  end

end
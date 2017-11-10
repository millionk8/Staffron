class CompanyPolicy < ApplicationPolicy
  def show?
    user.admin? && user.company.id == record.id
  end

  def update?
    user.admin? && user.company.id == record.id
  end
end
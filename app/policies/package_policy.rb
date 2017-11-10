class PackagePolicy < ApplicationPolicy
  def select?
    user.admin?
  end
end
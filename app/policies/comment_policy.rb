class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    user.admin? || record.author == user
  end

  def destroy?
    user.admin? || record.author == user
  end
end
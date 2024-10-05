class FeedbackPolicy < ApplicationPolicy
  def create?
    !user.admin?
  end

  def destroy?
    !user.admin? && user == record.user
  end

  def edit?
    !user.admin? && user == record.user
  end

  def update?
    !user.admin? && user == record.user
  end

  class Scope < ApplicationPolicy::Scope
  end
end

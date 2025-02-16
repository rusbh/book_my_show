class FeedbackPolicy < ApplicationPolicy
  def create?
    !admin?
  end

  def destroy?
    record_owner?
  end

  def edit?
    record_owner?
  end

  def update?
    record_owner?
  end

  class Scope < ApplicationPolicy::Scope
  end
end

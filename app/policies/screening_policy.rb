class ScreeningPolicy < ApplicationPolicy
  def create?
    admin?
  end

  def destroy?
    admin?
  end

  def update?
    admin?
  end

  class Scope < ApplicationPolicy::Scope
  end
end

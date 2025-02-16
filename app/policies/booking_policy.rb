class BookingPolicy < ApplicationPolicy
  def create?
    !admin?
  end

  def update?
    !admin?
  end

  def destroy?
    !admin?
  end

  class Scope < ApplicationPolicy::Scope
  end
end

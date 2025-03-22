class UserPolicy < ApplicationPolicy
  def show?
    !admin?
  end

  class Scope < ApplicationPolicy::Scope
  end
end

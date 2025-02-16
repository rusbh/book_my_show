class UserPolicy < ApplicationPolicy
  def index?
    !admin?
  end

  class Scope < ApplicationPolicy::Scope
  end
end

class UserPolicy < ApplicationPolicy
  def index?
    !user.admin?
  end

  class Scope < ApplicationPolicy::Scope
  end
end

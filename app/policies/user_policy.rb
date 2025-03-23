class UserPolicy < ApplicationPolicy
  def show?
    !admin?
  end

  def change_avatar?
    !admin?
  end

  class Scope < ApplicationPolicy::Scope
  end
end

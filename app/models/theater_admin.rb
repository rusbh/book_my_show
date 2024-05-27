class TheaterAdmin < ApplicationRecord
  after_create :set_user_admin_true
  after_destroy :set_admin_false

  belongs_to :theater
  belongs_to :user

  private

  def set_user_admin_true
    user.update(admin: true)
  end

  def set_admin_false
    user.update(admin: false)
  end
end

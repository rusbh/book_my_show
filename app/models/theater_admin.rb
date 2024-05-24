class TheaterAdmin < ApplicationRecord
  after_create :set_user_admin

  belongs_to :theater
  belongs_to :user

  private

  def set_user_admin
    user.update(admin: true)
  end
end

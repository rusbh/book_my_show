class TheaterAdmin < ApplicationRecord
  after_create :set_user_admin_true
  after_destroy :set_admin_false

  belongs_to :theater
  belongs_to :user

  validates :user_id, uniqueness: { scope: :theater_id, message: 'this admin is already assigned to this theater.' }
  validates :user_id, uniqueness: { message: 'Admin can only be assigned to one theater' }

  private

  def set_user_admin_true
    user.update(admin: true)
  end

  def set_admin_false
    user.update(admin: false)
  end
end

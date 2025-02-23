class TheaterAdmin < ApplicationRecord
  belongs_to :theater
  belongs_to :admin, class_name: 'User', foreign_key: 'user_id'

  enum :status, inactive: 0, active: 1

  validates :user_id, uniqueness: { scope: :theater_id, message: 'this admin is already assigned to this theater.' }
end

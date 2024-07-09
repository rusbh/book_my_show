class TheaterAdmin < ApplicationRecord
  belongs_to :theater
  belongs_to :user

  enum status: %i[inactive active]

  validates :user_id, uniqueness: { scope: :theater_id, message: 'this admin is already assigned to this theater.' }
end

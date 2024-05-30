class Screen < ApplicationRecord
  belongs_to :theater

  has_many :bookings, dependent: :destroy
  
  has_many :screen_shows, dependent: :destroy
  has_many :shows, through: :screen_shows

  enum status: %i[idle running in_maintenance unavailable]
  validates :screen_no, :seats, presence: true
end

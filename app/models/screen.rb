class Screen < ApplicationRecord
  belongs_to :theater

  enum status: %i[idle running in_maintenance unavailable]
  validates :screen_no, :seats, presence: true
end

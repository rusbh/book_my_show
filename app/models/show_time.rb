class ShowTime < ApplicationRecord
  belongs_to :screening
  has_many :bookings, dependent: :destroy

  validates :at_timeof, :seats, presence: true
  validates :seats, numericality: { greater_than_or_equal_to: 0 }

  def formatted_time
    return unless at_timeof > Time.current

    at_timeof.strftime("%d %B, %y at %I:%M %p")
  end
end

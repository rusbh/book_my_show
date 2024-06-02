class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show
  belongs_to :screen
  
  after_create :decrement_seats
  before_create :seats_not_available
  
  enum status: %i[confirmed cancelled]

  validates :ticket, presence: true, inclusion: { in: 1..10, message: 'You can only book maximum 10 tickets' }
  validates :booking_date, presence: true

  def decrement_seats
    ticket_purchased = self.ticket
    seats_available = self.screen.seats

    seats_remaining = seats_available - ticket_purchased

    @screen = Screen.find_by(id: self.screen_id)
    @screen.seats = seats_remaining
    @screen.save
  end

  def seats_not_available
    if self.screen.seats < self.ticket
      errors.add(:base, 'Not enough seats available')
    end
  end
end

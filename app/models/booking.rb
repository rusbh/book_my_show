class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :screening

  after_create :decrement_seats
  before_create :seats_not_available

  enum status: { confirmed: 0, cancelled: 1 }

  validates :ticket, presence: true, inclusion: { in: 1..10, message: 'You can only book maximum 10 tickets' }
  validates :booking_date, presence: true

  scope :past, -> { where('booking_date < ?', Time.current).where(status: :confirmed).includes(screening: [:show, :screen]) }
  scope :upcoming, -> { where('booking_date >= ?', Time.current).where(status: :confirmed).includes(screening: [:show, :screen]) }
  scope :cancelled, -> { where(status: :cancelled).includes(screening: [:show, :screen]) }

  def send_booking_confirmed
    BookingMailer.booking_confirmation(self).deliver_later
  end

  def decrement_seats
    ticket_purchased = self.ticket
    screen = self.screening.screen

    screen.seats -= ticket_purchased
    screen.save
  end

  def seats_not_available
    if screening.screen.seats < self.ticket
      errors.add(:base, 'Not enough seats available')
      throw(:abort)
    end
  end
end

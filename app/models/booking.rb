class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :screening
  belongs_to :show_timing

  after_create :decrement_seats
  before_create :seats_not_available, :show_time_in_past
  before_destroy :booking_got_deleted

  enum status: { confirmed: 0, cancelled: 1 }

  validates :ticket, presence: true, inclusion: { in: 1..10, message: 'You can only book maximum 10 tickets' }
  validates :booking_date, :total_price, presence: true

  scope :confirmed, -> { where(status: :confirmed) }
  scope :past, -> { where('booking_date < ?', Time.current).confirmed.includes(screening: [:show, { screen: :theater } ]) }
  scope :upcoming, -> { where('booking_date >= ?', Time.current).confirmed.includes(screening: [:show, { screen: :theater } ]) }
  scope :cancelled, -> { where(status: :cancelled).includes(screening: [:show, { screen: :theater } ]) }

  def send_booking_confirmed_mail
    BookingMailer.booking_confirmation(self).deliver_later
  end

  def send_booking_cancelled_mail
    BookingMailer.booking_cancelled(self).deliver_later
  end

  def booking_got_deleted
    BookingMailer.booking_deleted_unexpected(self).deliver_now
  end

  def decrement_seats
    self.show_timing.seats -= self.ticket
    self.show_timing.save
  end

  def increment_seats
    self.show_timing.seats += self.ticket
    self.show_timing.save
  end

  def seats_not_available
    if show_timing.seats < self.ticket
      errors.add(:base, "Only #{show_timing.seats} seats available on your selected time")
      throw(:abort)
    end
  end

  def show_time_in_past
    if self.show_timing.at_timeof < Time.current
      errors.add(:base, "you can't select previous time")
      throw(:abort)
    end
  end
end

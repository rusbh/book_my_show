class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :screening
  belongs_to :show_time

  before_create :seats_not_available, :show_time_in_past
  after_create_commit :decrement_seats
  before_destroy :booking_got_deleted

  enum :status, confirmed: 0, cancelled: 1

  validates :ticket,
            presence: true,
            inclusion: {
              in: 1..10,
              message: "You can only book maximum 10 tickets",
            }
  validates :booking_date, :total_price, presence: true

  scope :confirmed, -> { where(status: :confirmed) }
  scope :past, lambda {
    where(booking_date: ...Time.current).confirmed.includes(screening: [:show, { screen: :theater }])
  }
  scope :upcoming, lambda {
    where(booking_date: Time.current..).confirmed.includes(screening: [:show, { screen: :theater }])
  }
  scope :cancelled, -> {
    where(status: :cancelled).includes(screening: [:show, { screen: :theater }])
  }

  def send_booking_confirmed_mail
    BookingMailer.booking_confirmation(self).deliver_later
  end

  def send_booking_cancelled_mail
    return if show_time.at_timeof <= Time.current

    BookingMailer.booking_cancelled(self).deliver_later
  end

  def booking_got_deleted
    return if show_time.at_timeof <= Time.current

    BookingMailer.booking_deleted_unexpected(self).deliver_now
  end

  def decrement_seats
    show_time.seats -= ticket
    show_time.save
  end

  def increment_seats
    show_time.seats += ticket
    show_time.save
  end

  def seats_not_available
    return if show_time.seats >= ticket

    errors.add(
      :base,
      "Only #{show_time.seats} seats available on your selected time",
    )
    throw(:abort)
  end

  def show_time_in_past
    return if show_time.at_timeof >= Time.current

    errors.add(:base, "you can't select previous time")
    throw(:abort)
  end
end

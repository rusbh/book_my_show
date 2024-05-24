class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show
  belongs_to :screen

  enum status: %i[confirmed cancelled]

  validates :ticket, presence: true, inclusion: { in: 1..10, message: 'You can only book maximum 10 tickets' }
  validates :booking_date, presence: true
end

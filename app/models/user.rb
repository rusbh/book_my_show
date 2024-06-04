class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :theater_admins
  has_many :theaters, through: :theater_admins

  has_many :bookings, dependent: :destroy

  validates :name, presence: true

  def past_bookings
    bookings.past
  end

  def upcoming_bookings
    bookings.upcoming
  end

  def cancelled_bookings
    bookings.cancelled
  end
end

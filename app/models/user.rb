class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :theater_admins, dependent: :destroy
  has_many :theaters, through: :theater_admins
  has_many :bookings, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :event_requests, dependent: :destroy

  has_one_attached :avatar, dependent: :destroy do |attachable|
    attachable.variant(
      :display,
      resize_to_fit: [40, 40],
      preprocessed: true,
    )
  end

  validates :name, presence: true

  enum :status, active: 0, inactive: 1

  scope :active, -> { where(status: :active) }

  def send_admin_invitation_email
    token, hashed = Devise.token_generator.generate(User, :reset_password_token)
    update!(reset_password_token: hashed, reset_password_sent_at: Time.now.utc)
    save!
    AdminMailer.admin_invitation(self, token).deliver_later
  end

  def past_bookings
    bookings.past
  end

  def upcoming_bookings
    bookings.upcoming
  end

  def cancelled_bookings
    bookings.cancelled
  end

  def has_booked?(show)
    bookings.confirmed.joins(screening: :show).exists?(screenings: { show: })
  end

  def has_booked_in_theater?(theater)
    bookings.confirmed.joins(screening: { screen: :theater }).exists?(screens: { theater: })
  end
end

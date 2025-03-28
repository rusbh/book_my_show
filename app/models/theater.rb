class Theater < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  audited
  has_associated_audits

  has_many :screens, dependent: :destroy
  has_many :shows, through: :screens
  has_many :feedbacks, as: :feedbackable, dependent: :destroy

  has_many :theater_admins, dependent: :destroy
  has_many :admins, through: :theater_admins, source: :admin
  has_many :event_requests, dependent: :destroy

  enum :status, inactive: 0, active: 1

  validates :name, :address, presence: true
  validates :name, uniqueness: true
  validates :pincode, presence: true, length: { is: 6 }

  scope :active, -> { where(status: :active) }

  def average_rating
    feedbacks.average(:rating).to_f.round(1)
  end
end

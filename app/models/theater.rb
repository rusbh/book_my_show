class Theater < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :city

  has_many :screens, dependent: :destroy
  has_many :shows, through: :screens
  has_many :feedbacks, as: :commentable, dependent: :destroy
  has_many :bookings, dependent: :destroy

  has_many :theater_admins
  has_many :admins, through: :theater_admins, source: :user

  validates :name, :address, presence: true
end

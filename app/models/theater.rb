class Theater < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :city

  has_many :screens, dependent: :destroy
  has_many :shows, through: :screens
  has_many :feedbacks, as: :commentable, dependent: :destroy

  has_many :theater_admins, dependent: :destroy
  has_many :admins, through: :theater_admins, source: :user

  validates :name, :address, presence: true, uniqueness: true

  def average_rating
    feedbacks.average(:rating).to_f.round(1)
  end
end

class Theater < ApplicationRecord
  belongs_to :city

  has_many :screens, dependent: :destroy
  has_many :feedbacks, as: :commentable

  has_many :theater_admins
  has_many :admins, through: :theater_admins, source: :user

  validates :name, :address, presence: true
end

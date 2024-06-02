class City < ApplicationRecord
  has_many :theaters

  validates :name, :state, presence: true, uniqueness: true
end

class Theater < ApplicationRecord
  belongs_to :city

  validates :name, :address, presence: true
end

class ScreenShow < ApplicationRecord
  belongs_to :screen
  belongs_to :show

  validates :price, :start_date, :end_date, presence: true
end

class ScreenShow < ApplicationRecord
  belongs_to :screen
  belongs_to :show

  validates :start_date, :end_date, presence: true
end

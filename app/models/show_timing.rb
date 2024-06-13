class ShowTiming < ApplicationRecord
  belongs_to :screening
  has_many :booking, dependent: :destroy

  validates :at_timeof, presence: true

  def formatted_time
    at_timeof.strftime("%d %B, %y at %H:%M %p")
  end
end

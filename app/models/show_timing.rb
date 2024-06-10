class ShowTiming < ApplicationRecord
  belongs_to :screening
  has_one :booking, dependent: :destroy

  validates :time, presence: true

  def formatted_time
    time.strftime("%I:%M %p")
  end
end

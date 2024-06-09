class ShowTiming < ApplicationRecord
  belongs_to :screening
  has_one :booking, dependent: :destroy

  def formatted_time
    time.strftime("%I:%M %p")
  end
end

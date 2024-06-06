class ScreeningInfoUpdateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # if screening have start date and end date
    # if that date passes start date should be greater than current time
    # so user can not select past dates for bookings

    Screening.where('start_date < ?', Date.today).each do |screening|
      screening.update(start_date: Date.today)
    end
  end
end

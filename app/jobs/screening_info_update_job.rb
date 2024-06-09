class ScreeningInfoUpdateJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # if screening have start date and end date
    # if date passes start date,it should be greater than current time
    # so user can not select past dates for bookings

    Screening.where('start_date < ?', Date.today).each do |screening|
      screening.update(start_date: Date.today) if screening.start_date < Date.today
    end
  end
end

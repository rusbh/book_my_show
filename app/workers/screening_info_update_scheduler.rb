require 'sidekiq-scheduler'

class ScreeningInfoUpdateScheduler
  # if screening have start date and end date
  # if that date passes start date should be greater than current time
  # user can not select past dates

  include Sidekiq::Worker

  def perform(*args)
    puts "hi from cron"
  end
end
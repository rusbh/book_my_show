class ExpiredScreeningCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    expired_screenings = Screening.where('end_date < ?', Date.current)

    count = expired_screenings.count
    expired_screenings.find_each(&:destroy)

    Rails.logger.info "[ExpiredScreeningCleanupJob] Deleted #{count} expired screenings"
  end
end

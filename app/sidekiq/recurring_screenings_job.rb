class RecurringScreeningsJob
  include Sidekiq::Job

  def perform(screening_id)
    screening = Screening.find(screening_id)
    start_date = screening.start_date
    end_date = screening.end_date
    show_times = screening.show_timings.map(&:at_timeof)

    # deletes current date's unwanted entries when show_timing created, i can't find anything else :(
    screening.show_timings.destroy_all

    (start_date..end_date).each do |date|
      show_times.each do |show_time|
        screening.show_timings.create(at_timeof: Time.zone.local(date.year, date.month, date.day, show_time.hour,
                                                                 show_time.min, show_time.sec))
      end
    end
  end
end

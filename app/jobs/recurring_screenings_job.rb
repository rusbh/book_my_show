class RecurringScreeningsJob < ApplicationJob
  queue_as :default

  def perform(screening_id)
    screening = Screening.find(screening_id)
    start_date = screening.start_date
    end_date = screening.end_date
    show_times_with_seats = screening.show_times.map do |st|
      { at_timeof: st.at_timeof, seats: st.seats }
    end
    screening.show_times.destroy_all # deletes current date's unwanted entries when show times created

    (start_date..end_date).each do |date|
      show_times_with_seats.each do |show_time|
        screening.show_times.create(
          at_timeof: Time.zone.local(
            date.year,
            date.month,
            date.day,
            show_time[:at_timeof].hour,
            show_time[:at_timeof].min,
            show_time[:at_timeof].sec,
          ),
          seats: screening.screen.seats,
        )
      end
    end
  end
end

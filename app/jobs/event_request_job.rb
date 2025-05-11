class EventRequestJob < ApplicationJob
  queue_as :default

  def perform(event_request_id)
    er = EventRequest.find(event_request_id)

    Show.create!(
      name: er.name,
      description: er.description,
      poster: er.poster.blob,
      cast: er.cast,
      languages: er.languages,
      genres: er.genres,
      category: er.category,
      duration: er.duration,
      release_date: er.release_date,
      event_request: er,
    )

    EventRequestMailer.new_event_request(er).deliver_later
  end
end

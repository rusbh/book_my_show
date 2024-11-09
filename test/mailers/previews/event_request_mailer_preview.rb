# Preview all emails at http://localhost:3000/rails/mailers/event_request_mailer
class EventRequestMailerPreview < ActionMailer::Preview
  def new_event_request
    EventRequestMailer.new_event_request(EventRequest.last)
  end

  def theater_event_request
    EventRequestMailer.theater_event_request(EventRequest.last)
  end

  def event_request_approved
    EventRequestMailer.event_request_approved(EventRequest.last)
  end

  def event_request_rejected
    EventRequestMailer.event_request_rejected(EventRequest.last)
  end
end

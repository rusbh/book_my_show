class EventRequestMailer < ApplicationMailer
  helper ApplicationHelper

  def new_event_request(event_request)
    @event_request = event_request
    mail(to: "superadmin@bms.com", subject: "New event request for BMS theater portal")
  end

  def theater_event_request(event_request)
    @event_request = event_request
    @theater = event_request.theater
    mail(to: @theater.admins.pluck(:email), subject: "Event hosting request for #{@theater.name.humanize}")
  end

  def event_request_approved(event_request)
    @event_request = event_request
    mail(to: @event_request.user.email, subject: "Your Theater request has been approved")
  end

  def event_request_rejected(event_request)
    @event_request = event_request
    mail(to: @event_request.user.email, subject: "Your Theater request has been approved")
  end
end

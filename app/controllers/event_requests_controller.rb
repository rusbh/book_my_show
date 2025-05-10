class EventRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_theater

  def new
    @event_request = EventRequest.new
    @previous_requests = EventRequest.where(
      theater: @theater,
      user: current_user,
    )
  end

  def create
    @event_request = EventRequest.new(event_request_params)
    @event_request.theater = @theater
    @event_request.user = current_user

    if @event_request.save
      EventRequestJob.perform_async(@event_request.id)
      redirect_to(
        theater_url(@theater),
        notice: "Event request was successfully submitted.",
      )
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  private

  def set_theater
    @theater = Theater.friendly.find(params[:theater_id])
  end

  def event_request_params
    params.expect(event_request: [
      :name,
      :description,
      :poster,
      :cast,
      :category,
      :duration,
      :release_date,
      :end_date,
      :at_timeof,
      :status,
      :permit,
      { languages: [], genres: [] },
    ])
  end
end

class EventRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_theater

  def new
    @event_request = EventRequest.new
    @previous_requests = EventRequest.where(theater: @theater, user: current_user)
  end

  def create
    @event_request = EventRequest.new(event_request_params)
    @event_request.theater = @theater
    @event_request.user = current_user

    respond_to do |format|
      if @event_request.save
        EventRequestJob.perform_async(@event_request.id)
        format.html { redirect_to theater_url(@theater), notice: 'Event request was successfully submitted.' }
        format.json { render :show, status: :created, location: @event_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_request.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_theater
    @theater = Theater.friendly.find(params[:theater_id])
  end

  def event_request_params
    params.require(:event_request).permit(:name, :description, :poster, :cast, :category, :duration, :release_date, :end_date, :at_timeof,
                                          :status, :permit, languages: [], genres: [])
  end
end

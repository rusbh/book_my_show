class EventRequestsController < ApplicationController
  before_action :set_theater

  def new
    @event_request = EventRequest.new
  end

  def create
    @event_request.theater = @theater
    @event_request = EventRequest.new(event_request_params)

    respond_to do |format|
      if @event_request.save
        format.html { redirect_to event_request_url(@event_request), notice: 'Event request was successfully created.' }
        format.json { render :show, status: :created, location: @event_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_request.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_theater
    @theater = Theater.friendly.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  # def set_event_request
  #   @event_request = EventRequest.find(params[:id])
  # end

  # Only allow a list of trusted parameters through.
  def event_request_params
    params.require(:event_request).permit(:name, :description, :poster, :cast, :languages, :genres,
                                          :category, :duration, :release_date, :status, permits: [])
  end
end

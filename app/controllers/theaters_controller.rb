class TheatersController < ApplicationController
  before_action :set_theater, only: %i[show]

  # GET /theaters or /theaters.json
  def index
    @theaters = Theater.all.includes(:city)
  end

  # GET /theaters/1 or /theaters/1.json
  def show
    @feedback = @theater.feedbacks.new
    @feedbacks_count = @theater.feedbacks.count
    @theater_shows = Show.joins(screenings: :screen).where(screens: { theater_id: @theater.id }).distinct.includes(poster_attachment: :blob)
    @theater_feedbacks = @theater.feedbacks.order(created_at: :desc).includes(:user)
    @user_has_feedback = @theater.feedbacks.find_by(user_id: current_user&.id)
    @user_has_booked_in_theater = current_user&.has_booked_in_theater?(@theater)

    @show_screening_details = @theater_shows.map do |show|
      screenings = show.screenings.joins(:screen).where(screens: { theater_id: @theater.id })
      { show:, screenings: }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_theater
    @theater = Theater.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def theater_params
    params.require(:theater).permit(:name, :address, :city_id)
  end
end

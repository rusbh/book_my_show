class TheatersController < ApplicationController
  before_action :set_theater, only: %i[show]

  def index
    @pagy, @theaters = pagy(Theater.active)
  end

  def show
    @theater_shows = Show.active.joins(screenings: :screen).where(screens: { theater_id: @theater.id }).distinct

    @show_screening_details = @theater_shows.map do |show|
      screenings = show.screenings.includes(:screen).where(screens: { theater_id: @theater.id })
      { show:, screenings: }
    end

    @feedback = @theater.feedbacks.new

    @feedbacks_count = @theater.feedbacks.count
    @pagy, @theater_feedbacks = pagy(@theater.feedbacks.includes(:user).order(created_at: :desc))

    @user_has_booked_in_theater = current_user&.has_booked_in_theater?(@theater)
    @user_has_feedback = @theater.feedbacks.find_by(user_id: current_user&.id)
  end

  private

  def set_theater
    @theater = Theater.friendly.find(params[:id])
  end

  def theater_params
    params.require(:theater).permit(:name, :address)
  end
end

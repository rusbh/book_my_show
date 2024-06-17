class ShowsController < ApplicationController
  before_action :set_show, only: %i[show]

  # GET /shows or /shows.json
  def index
    @shows = Show.all
    @movies = Show.movies
    @plays = Show.plays
    @sports = Show.sports
    @events = Show.events
  end 

  # GET /shows/1 or /shows/1.json
  def show
    @show_feedbacks = @show.feedbacks.order(created_at: :desc)
    @user_has_feedback = @show.feedbacks.find_by(user_id: current_user&.id)
    @user_has_booked = current_user&.user_has_booked?(@show)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_show
    @show = Show.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def show_params
    params.require(:show).permit(:name, :description, :poster, :cast, :language, :genre, :category, :imdb_rating,
                                 :price, :status, :duration, :release_date)
  end
end

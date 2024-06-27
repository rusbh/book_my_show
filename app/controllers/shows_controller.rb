class ShowsController < ApplicationController
  before_action :set_show, only: %i[show]

  # GET /shows or /shows.json
  def index
    @q = Show.active.ransack(params[:q])
    @all_shows = @q.result(distinct: true).includes(poster_attachment: :blob)

    if params[:booking_available] == '1'
      @all_shows = @all_shows.joins(:screenings).distinct
    end

    @movies = @all_shows.movies
    @plays = @all_shows.plays
    @sports = @all_shows.sports
    @events = @all_shows.events
  end

  # GET /shows/1 or /shows/1.json
  def show
    @feedback = @show.feedbacks.new
    @reviews_count = @show.feedbacks.count
    @show_feedbacks = @show.feedbacks.order(created_at: :desc).includes(:user)
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

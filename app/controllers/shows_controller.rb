class ShowsController < ApplicationController
  before_action :set_show, only: %i[show]

  # GET /shows or /shows.json
  def index
    @shows = Show.all
    @movies = Show.movies
    @plays = Show.plays
    @sports = Show.sports
  end

  # GET /shows/1 or /shows/1.json
  def show; end

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

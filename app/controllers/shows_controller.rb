class ShowsController < ApplicationController
  before_action :set_show, only: %i[show languages]

  def index
    @q = Show.active.ransack(params[:q])
    @pagy, @all_shows = pagy(@q.result(distinct: true), items: 20)

    return unless params[:booking_available] == '1'

    @all_shows = @all_shows.joins(:screenings).distinct
  end

  def show
    @feedback = @show.feedbacks.new

    @reviews_count = @show.feedbacks.count
    @pagy, @show_feedbacks = pagy(@show.feedbacks.includes(:user).order(created_at: :desc))

    @user_has_feedback = @show.feedbacks.find_by(user_id: current_user&.id)
    @user_has_booked = current_user&.has_booked?(@show)
  end

  def languages
    render json: @show.languages
  end

  private

  def set_show
    @show = Show.friendly.find(params[:id])
  end

  def show_params
    params.require(:show).permit(:name, :description, :poster, :cast, :category, :imdb_rating,
                                 :price, :status, :duration, :release_date, languages: [], genres: [])
  end
end

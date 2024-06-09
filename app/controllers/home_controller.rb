class HomeController < ApplicationController
  def index
    @recommended_shows = Show.recommended
    @action_shows = Show.action
    @gujarati_shows = Show.gujarati
    @except_movies = Show.except_movies
  end
end

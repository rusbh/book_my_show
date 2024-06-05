class HomeController < ApplicationController
  def index
    @recommened_shows = Show.recommened
    @recommened_plays = Show.plays
    @gujarati_shows = Show.gujarati
    @action_shows = Show.action
    @except_movies = Show.except_movies
  end
end

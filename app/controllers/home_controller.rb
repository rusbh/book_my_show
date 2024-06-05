class HomeController < ApplicationController
  def index
    @recommened_shows = Show.recommened
    @recommened_plays = Show.plays
    @hindi_shows = Show.hindi_shows
  end
end

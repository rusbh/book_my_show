class ShowListComponent < ApplicationComponent
  include ShowsHelper
  attr_reader :shows

  def initialize(shows:)
    @shows = shows
  end
end

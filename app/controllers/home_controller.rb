class HomeController < ApplicationController
  LANGUAGES = %w[hindi english gujarati tamil telugu].freeze

  def index
    @recommended_shows = Show.recommended
    @except_movies = Show.except_movies

    @shows_by_language = LANGUAGES.each_with_object({}) do |language, hash|
      hash[language] = Show.by_language(language)
    end
  end
end

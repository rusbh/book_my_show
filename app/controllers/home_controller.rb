class HomeController < ApplicationController
  def index
    @recommended_shows = Show.recommended
    @except_movies = Show.except_movies

    @shows_by_language = Show.languages.collect { |_k, v| v }.each_with_object({}) do |lang, hash|
      hash[lang] = Show.by_language(lang)
    end
  end
end

json.extract! show, :id, :name, :description, :poster, :cast, :language, :genre, :category, :imdb_rating, :price, :status, :duration, :release_date, :created_at, :updated_at
json.url show_url(show, format: :json)
json.poster url_for(show.poster)

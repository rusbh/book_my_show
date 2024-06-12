class TransferRatingsToFeedbacks < ActiveRecord::Migration[7.1]
  def change
    add_column :feedbacks, :rating, :decimal, precision: 2, scale: 1
    remove_column :shows, :imdb_rating
  end
end

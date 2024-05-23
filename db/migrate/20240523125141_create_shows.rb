class CreateShows < ActiveRecord::Migration[7.1]
  def change
    create_table :shows do |t|
      t.string :name
      t.text :description
      t.string :cast, array: true, default: []
      t.integer :language
      t.integer :genre
      t.integer :category
      t.decimal :imdb_rating, precision: 2, scale: 1
      t.integer :price
      t.integer :status, default: 0
      t.integer :duration, default: 120
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end

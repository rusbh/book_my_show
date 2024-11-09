class CreateEventRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :event_requests do |t|
      t.references :theater, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :cast
      t.string :languages, array: true, default: []
      t.string :genres, array: true, default: []
      t.integer :category
      t.integer :duration, default: 120
      t.date :release_date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

class CreateScreenShows < ActiveRecord::Migration[7.1]
  def change
    create_table :screen_shows do |t|
      t.references :screen, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true

      t.timestamps
    end
  end
end

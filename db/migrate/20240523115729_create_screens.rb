class CreateScreens < ActiveRecord::Migration[7.1]
  def change
    create_table :screens do |t|
      t.integer :screen_no
      t.integer :seats, default: 150
      t.integer :status, default: :idle
      t.references :theater, null: false, foreign_key: true

      t.timestamps
    end
  end
end

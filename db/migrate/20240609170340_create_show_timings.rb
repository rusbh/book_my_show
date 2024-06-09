class CreateShowTimings < ActiveRecord::Migration[7.1]
  def change
    create_table :show_timings do |t|
      t.time :time
      t.references :screening, null: false, foreign_key: true

      t.timestamps
    end
  end
end

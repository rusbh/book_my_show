class CreateTheaters < ActiveRecord::Migration[7.1]
  def change
    create_table :theaters do |t|
      t.string :name
      t.text :address
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end

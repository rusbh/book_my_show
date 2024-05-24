class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.integer :ticket, default: 1
      t.datetime :booking_date
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true
      t.references :screen, null: false, foreign_key: true

      t.timestamps
    end
  end
end

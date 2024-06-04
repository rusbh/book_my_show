class ChangesOnBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :show_id
    remove_column :bookings, :screen_id
    add_reference :bookings, :screening, null: false, foreign_key: true
  end
end

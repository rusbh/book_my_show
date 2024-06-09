class AddShowTimingToBookings < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :show_timing, null: false, foreign_key: true
  end
end

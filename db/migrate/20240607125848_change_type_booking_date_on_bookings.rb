class ChangeTypeBookingDateOnBookings < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :booking_date, :date
  end
end

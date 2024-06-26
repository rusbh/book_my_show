class AddTotalPriceOnBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :total_price, :decimal
  end
end

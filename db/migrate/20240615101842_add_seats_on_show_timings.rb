class AddSeatsOnShowTimings < ActiveRecord::Migration[7.1]
  def change
    remove_column :screens, :seats
    add_column :show_timings, :seats, :integer, default: 150
  end
end

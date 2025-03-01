class RenameShowTimingToShowTime < ActiveRecord::Migration[8.0]
  def change
    rename_table :show_timings, :show_times
    rename_column :bookings, :show_timing_id, :show_time_id
  end
end

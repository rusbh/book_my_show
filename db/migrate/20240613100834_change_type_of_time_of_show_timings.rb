class ChangeTypeOfTimeOfShowTimings < ActiveRecord::Migration[7.1]
  def change
    remove_column :show_timings, :time
    add_column :show_timings, :at_timeof, :datetime
  end
end

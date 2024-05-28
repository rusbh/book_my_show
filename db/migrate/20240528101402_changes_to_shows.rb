class ChangesToShows < ActiveRecord::Migration[7.1]
  def change
    remove_column :shows, :start_date
    remove_column :shows, :end_date
    add_column :shows, :release_date, :date
  end
end

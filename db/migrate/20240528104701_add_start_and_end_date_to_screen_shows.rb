class AddStartAndEndDateToScreenShows < ActiveRecord::Migration[7.1]
  def change
    add_column :screen_shows, :start_date, :date
    add_column :screen_shows, :end_date, :date
  end
end

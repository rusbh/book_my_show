class RenameTableScreenShowsToScreenings < ActiveRecord::Migration[7.1]
  def change
    rename_table :screen_shows, :screenings
  end
end

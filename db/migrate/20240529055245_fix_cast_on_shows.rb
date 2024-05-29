class FixCastOnShows < ActiveRecord::Migration[7.1]
  def change
    remove_column :shows, :cast
    add_column :shows, :cast, :string
  end
end

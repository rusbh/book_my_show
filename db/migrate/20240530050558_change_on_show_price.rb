class ChangeOnShowPrice < ActiveRecord::Migration[7.1]
  def change
    remove_column :shows, :price
    add_column :screen_shows, :price, :integer
  end
end

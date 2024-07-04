class ChangeScreenTypeOnScreens < ActiveRecord::Migration[7.1]
  def change
    remove_column :screens, :screen_name
    add_column :screens, :screen_name, :string
  end
end

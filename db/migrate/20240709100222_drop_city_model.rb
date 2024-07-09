class DropCityModel < ActiveRecord::Migration[7.1]
  def change
    drop_table :cities
  end
end

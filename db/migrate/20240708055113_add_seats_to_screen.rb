class AddSeatsToScreen < ActiveRecord::Migration[7.1]
  def change
    add_column :screens, :seats, :integer, default: 150
  end
end

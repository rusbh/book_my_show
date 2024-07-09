class AddStatusToMultipleModels < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :status, :integer, default: 0
    add_column :theaters, :status, :integer, default: 0
    add_column :theater_admins, :status, :integer, default: 0
  end
end

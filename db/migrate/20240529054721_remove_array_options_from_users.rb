class RemoveArrayOptionsFromUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :shows, :cast, :string
  end
end

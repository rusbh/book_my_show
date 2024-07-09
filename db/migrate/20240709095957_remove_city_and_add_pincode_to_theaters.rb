class RemoveCityAndAddPincodeToTheaters < ActiveRecord::Migration[7.1]
  def change
    remove_column :theaters, :city_id
    add_column :theaters, :pincode, :integer
  end
end

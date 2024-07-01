class RemoveUsersIndexOnTheaterAdmins < ActiveRecord::Migration[7.1]
  def change
    remove_index :theater_admins, name: :unique_user
    add_index :theater_admins, :user_id, name: "index_theater_admins_on_user_id"
  end
end

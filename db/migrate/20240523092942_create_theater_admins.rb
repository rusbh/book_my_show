class CreateTheaterAdmins < ActiveRecord::Migration[7.1]
  def change
    create_table :theater_admins do |t|
      t.references :theater, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    remove_index :theater_admins, name: :index_theater_admins_on_user_id
    add_index :theater_admins, [ :user_id ], unique: true, name: "unique_user"
    add_index :theater_admins, [ :user_id, :theater_id ], unique: true, name: 'unique_pair_of_user_and_theater'
  end
end

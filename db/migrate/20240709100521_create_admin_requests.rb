class CreateAdminRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :admin_requests do |t|
      t.string :contact_email
      t.bigint :contact_no
      t.string :admin_emails
      t.string :theater_name
      t.text :theater_address
      t.integer :pincode
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :email
    column :name
    column :admin
    column :status
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :email
      row :name
      row :admin
      row :status
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "User" do
      f.input :email
      if f.object.new_record?
        f.input :name
        f.input :password, label: "Password (6 characters minimum)"
        f.input :password_confirmation
      end
      f.input :status
      f.input :admin
    end
    f.actions
  end

  permit_params :email, :password, :password_confirmation, :reset_password_token, :reset_password_sent_at,
                :remember_created_at, :name, :admin, :status
end

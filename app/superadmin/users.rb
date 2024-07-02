ActiveAdmin.register User do
  index do
    column :id
    column :email
    column :name
    column :admin
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :email
      row :name
      row :admin
      row :created_at
      row :updated_at
    end
    if user.admin?
      panel "Note:" do
        "If you have to revoke admin role you have to remove admin checkbox tick on editing user page."
      end
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
      f.input :admin
    end
    f.actions
  end

  permit_params :email, :password, :password_confirmation, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :admin
end

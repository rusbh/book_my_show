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
  end

  form do |f|
    f.inputs "User" do
      f.input :email
      if f.object.new_record?
        f.input :name
        f.input :password
        f.input :password_confirmation
      end
      f.input :admin
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :password, :password_confirmation, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :admin
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :admin]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

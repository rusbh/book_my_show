ActiveAdmin.register TheaterAdmin do
  index do
    selectable_column
    id_column
    column :theater
    column :user do |t|
      link_to t.user.email, superadmin_user_path(t.user)
    end
    column :status
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :theater, label: 'Select Theater'
      f.input :user, as: :select, collection: User.all.map { |user| [user.email, user.id] }, label: 'Select User'
      f.input :status
    end
    f.actions

    panel 'Note:' do
      "Admin can be assigned to more than one theater and Theater can have multiple admins assigned to it."
    end
  end

  show do
    attributes_table do
      row :theater
      row :user
      row :status
      row :created_at
      row :updated_at
    end
    panel 'Mail' do
      link_to 'Send Reset Password to Admin', send_reset_password_superadmin_theater_admin_path(resource), method: :put
    end
  end

  member_action :send_reset_password, method: :put do
    theater_admin = TheaterAdmin.find(params[:id])
    admin = theater_admin.user
    admin.send_admin_invitation_email
    redirect_to superadmin_theater_admins_path, notice: "Reset password instructions sent to #{admin.email}"
  end

  permit_params :theater_id, :user_id, :status
end

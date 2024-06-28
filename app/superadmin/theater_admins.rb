ActiveAdmin.register TheaterAdmin do
  form do |f|
    f.inputs do
      f.input :theater, label: 'Select Theater'
      f.input :user, as: :select, collection: User.all.map { |user| [user.email, user.id] }, label: 'Select User'
    end
    f.actions

    panel 'Note:' do
      "Admin can only be assigned only one theater, So one admin can't have multiple theaters assigned.
      However Theater can have multiple admins assigned to it."
    end
  end

  show do
    attributes_table do
      row :theater
      row :user
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

  permit_params :theater_id, :user_id
end

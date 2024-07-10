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
  end

  show do
    attributes_table do
      row :theater
      row :user
      row :status
      row :created_at
      row :updated_at
    end
  end

  permit_params :theater_id, :user_id, :status
end

ActiveAdmin.register TheaterAdmin do
  form do |f|
    f.inputs do
      f.input :theater
      f.input :user, as: :select, collection: User.all.map { |user| [user.email, user.id] }
    end
    f.actions
  end

  permit_params :theater_id, :user_id
end

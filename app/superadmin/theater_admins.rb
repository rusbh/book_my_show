ActiveAdmin.register TheaterAdmin do
  form do |f|
    f.inputs do
      f.input :theater
      f.input :user, as: :select, collection: User.all.map { |user| [user.email, user.id] }
    end
    f.actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :theater_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:theater_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

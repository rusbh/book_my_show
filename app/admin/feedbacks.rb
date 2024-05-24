ActiveAdmin.register Feedback do
  form do |f|
    f.inputs do
      f.input :type_of
      f.input :user, as: :select, collection: User.all.map { |user| [user.email, user.id] }
      f.input :comment
      f.input :commentable_type  # Show, Theater
      f.input :commentable_id #  1,2,3    Show.id, theater.id
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :comment, :type_of, :user_id, :commentable_type, :commentable_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:comment, :type_of, :user_id, :commentable_type, :commentable_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

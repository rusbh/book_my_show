ActiveAdmin.register ScreenShow do
  form do |f|
    f.inputs do
      f.input :screen, as: :select, collection: Theater.first.screens.map { |s| [s.screen_no, s.id] }
      f.input :show
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :screen_id, :show_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:screen_id, :show_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

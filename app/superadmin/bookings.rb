ActiveAdmin.register Booking do
  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: User.all.map { |user| [user.email, user.id] }
      f.input :show
      f.input :screen, as: :select, collection: Theater.first.screens.map { |s| [s.screen_no, s.id] }
      f.input :ticket
      f.input :booking_date
      f.input :status
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :ticket, :booking_date, :status, :user_id, :show_id, :screen_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:ticket, :booking_date, :status, :user_id, :show_id, :screen_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

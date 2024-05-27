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

  permit_params :ticket, :booking_date, :status, :user_id, :show_id, :screen_id
end

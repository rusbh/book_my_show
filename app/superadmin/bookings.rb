# ActiveAdmin.register Booking do
#   form do |f|
#     f.inputs do
#       f.input :user, as: :select, collection: User.all.map { |user| [user.email, user.id] }
#       f.input :screening
#       f.input :ticket
#       f.input :booking_date
#       f.input :status
#     end
#     f.actions
#   end

#   permit_params :ticket, :booking_date, :status, :user_id, :screening_id
# end

# ActiveAdmin.register Feedback do
#   form do |f|
#     f.inputs do
#       f.input :user, as: :select, collection: User.all.map { |user| [user.email, user.id] }
#       f.input :comment
#       f.input :rating
#       f.input :feedbackable_type  # Show, Theater
#       f.input :feedbackable_id #  1,2,3    Show.id, theater.id
#     end
#     f.actions
#   end

#   permit_params :comment, :rating, :user_id, :feedbackable_type, :feedbackable_id
# end

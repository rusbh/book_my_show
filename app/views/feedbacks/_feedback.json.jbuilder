json.extract! feedback, :id, :comment, :type_of, :user_id, :commentable_id, :commentable_type, :created_at, :updated_at
json.url feedback_url(feedback, format: :json)

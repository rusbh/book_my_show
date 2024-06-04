class FeedbacksController < ApplicationController
  before_action :authenticate_user!, notice: "you must login before to comment"

  def create
    @feedback = @commentable.feedbacks.new(feedback_params)
    @feedback.user = current_user
    if @feedback.save
      redirect_to [@commentable], notice: "Feedback was successfully submitted."
    else
      # render @commentable_url, status: :unprocessable_entity
    end
  end

  def feedback_params
    params.require(:feedback).permit(:comment)
  end
end
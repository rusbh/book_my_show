class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def create
    @feedback = @commentable.feedbacks.new(feedback_params)
    @feedback.user = current_user
    @feedback.save
    
    redirect_to @commentable, notice: "Feedback was successfully submitted."
  end

  def feedback_params
    params.require(:feedback).permit(:comment)
  end
end
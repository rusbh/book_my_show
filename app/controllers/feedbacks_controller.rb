class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def create
    @feedback = @commentable.feedbacks.new(feedback_params)
    @feedback.user = current_user
    authorize @feedback
    @feedback.save
    
    redirect_to @commentable, notice: "Feedback was successfully submitted."
  end

  def destroy
    @feedback = @commentable.feedbacks.find(params[:id])
    authorize @feedback
    @feedback.destroy
    redirect_to @commentable, notice: "Feedback was successfully deleted."
  end

  private

  def feedback_params
    params.require(:feedback).permit(:comment)
  end
end

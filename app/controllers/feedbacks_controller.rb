class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable

  def create
    @feedback = @commentable.feedbacks.new(feedback_params)
    @feedback.user = current_user
    authorize @feedback
    if @feedback.save
      redirect_to @commentable, notice: "Feedback was successfully submitted."
    else
      flash[:alert] = "All fields are required"
      render @commentable, status: :unprocessable_entity
    end
  end

  def destroy
    @feedback = @commentable.feedbacks.find(params[:id])
    authorize @feedback
    @feedback.destroy
    redirect_to @commentable, notice: "Feedback was successfully deleted."
  end

  private

  def feedback_params
    params.require(:feedback).permit(:comment, :rating)
  end

  def set_commentable
    @commentable = find_commentable
  end

  def find_commentable
    if params[:show_id]
      Show.friendly.find(params[:show_id])
    elsif params[:theater_id]
      Theater.friendly.find(params[:theater_id])
    else
      fail "Unsupported commentable"
    end
  end
end

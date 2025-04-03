class FeedbacksController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :set_feedbackable
  before_action :set_feedback, only: [:edit, :update, :destroy]

  def create
    @feedback = @feedbackable.feedbacks.new(feedback_params)
    authorize(@feedback)

    if @feedback.save
      redirect_to(@feedbackable)
    else
      flash[:alert] = "All fields are required"
      render(@feedbackable, status: :unprocessable_entity)
    end
  end

  def edit
    authorize(@feedback)
  end

  def update
    authorize(@feedback)
    @feedback.update(feedback_params)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to(@feedbackable) }
    end
  end

  def destroy
    authorize(@feedback)
    @feedback.destroy

    respond_to do |format|
      format.html { redirect_to(@feedbackable) }
      format.turbo_stream
    end
  end

  private

  def feedback_params
    params.expect(feedback: [
      :comment,
      :rating,
      :feedbackable_id,
      :feedbackable_type,
    ]).merge(user_id: current_user&.id)
  end

  def set_feedbackable
    @feedbackable = params[:show_id] ? Show.friendly.find(params[:show_id]) : Theater.friendly.find(params[:theater_id])
  end

  def set_feedback
    @feedback = @feedbackable.feedbacks.find(params[:id])
  end
end

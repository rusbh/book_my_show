class Theaters::FeedbacksController < FeedbacksController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Theater.friendly.find(params[:theater_id])
  end
end
class Shows::FeedbacksController < FeedbacksController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Show.friendly.find(params[:show_id])
  end
end
class FeedbacksController < ApplicationController
  before_action :set_theater
  before_action :set_feedback, only: %i[ show edit update destroy ]

  # GET /feedbacks or /feedbacks.json
  def index
    @feedbacks = Feedback.new
  end

  # GET /feedbacks/1 or /feedbacks/1.json
  def show
  end

  # GET /feedbacks/new
  def new
    @feedback = @theater.feedbacks.new
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks or /feedbacks.json
  def create
    @feedback = @theater.feedbacks.new(feedback_params.merge(user: current_user))

    respond_to do |format|
      if @feedback.save
        # format.turbo_stream
        format.html { redirect_to theater_url(@theater), notice: "Feedback was successfully created." }
        format.json { render :show, status: :created, location: @feedback }
      else
        # format.turbo_stream
        format.html { ren der :new, status: :unprocessable_entity }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feedbacks/1 or /feedbacks/1.json
  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        # format.turbo_stream
        format.html { redirect_to theater_url(@theater), notice: "Feedback was successfully updated." }
        format.json { render :show, status: :ok, location: @feedback }
      else
        # format.turbo_stream
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1 or /feedbacks/1.json
  def destroy
    @feedback.destroy!

    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: "Feedback was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feedback_params
      params.require(:feedback).permit(:comment, :type_of, :user_id, :commentable_id)
    end

    def set_theater
      @theater = Theater.friendly.find(params[:theater_id])
    end
end

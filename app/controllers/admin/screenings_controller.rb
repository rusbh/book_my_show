class Admin::ScreeningsController < Admin::BaseController
  before_action :set_theater
  before_action :set_screen
  before_action :set_screening, only: %i[show edit update destroy]
  before_action :set_show, only: %i[show edit update destroy]

  def index
    @screenings = @screen.screenings.joins(:show).where(shows: { status: :idle }).includes(show: [poster_attachment: :blob])
  end

  def new
    @screening = Screening.new
    @screening.show_timings.build
  end

  def create
    @screening = Screening.new(screening_params)
    authorize @screening

    respond_to do |format|
      if @screening.save
        RecurringScreeningsJob.perform_async(@screening.id)
        format.html do
          redirect_to admin_screen_screenings_path(@screen), notice: 'Screening was successfully created.'
        end
        format.json { render :screening, status: :created, location: @screening }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @screening.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    authorize @screening

    respond_to do |format|
      if @screening.update(screening_params)
        format.html do
          redirect_to admin_screen_screening_url(@screen, @screening), notice: 'Screening was successfully updated.'
        end
        format.json { render :screening, status: :ok, location: @screening }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @screening.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @show_timings = @screening.show_timings.order(at_timeof: :asc)
  end

  def destroy
    authorize @screening

    @screening.destroy!
    respond_to do |format|
      format.html { redirect_to admin_screen_screenings_url(@screen), notice: 'Screening was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_theater
    @theater_admin = TheaterAdmin.where(user: current_user).first
    @theater = @theater_admin.theater
  end

  def set_screen
    @screen = Screen.find(params[:screen_id])
  end

  def set_screening
    @screening = Screening.find(params[:id])
  end

  def set_show
    @show = Show.friendly.find(@screening.show_id)
  end

  def screening_params
    params.require(:screening).permit(:show_id, :screen_id, :price, :start_date, :end_date,
                                      show_timings_attributes: %i[id at_timeof seats _destroy])
  end
end

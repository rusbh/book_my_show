class Admin::ScreeningsController < Admin::BaseController
  before_action :set_theater
  before_action :set_screen
  before_action :set_screening, only: %i[show edit update destroy]
  before_action :set_show, only: %i[show edit update destroy]

  def index
    @screenings = @screen.screenings
  end

  def new
    @screening = Screening.new
  end

  def create
    @screening = Screening.new(screening_params)

    respond_to do |format|
      if @screening.save
        format.html do
          redirect_to admin_screen_screening_url(@screen, @screening), notice: 'Show was successfully created.'
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
    respond_to do |format|
      if @screening.update(screening_params)
        format.html do
          redirect_to admin_screen_screening_url(@screen, @screening), notice: 'screening was successfully updated.'
        end
        format.json { render :screening, status: :ok, location: @screening }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @screening.errors, status: :unprocessable_entity }
      end
    end
  end

  def show; end

  def destroy
    @screening.destroy!
    respond_to do |format|
      format.html { redirect_to admin_screen_screenings_url(@screen), notice: 'screening was successfully destroyed.' }
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
    params.require(:screening).permit(:show_id, :screen_id, :price, :start_date, :end_date)
  end
end

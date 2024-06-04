class Admin::ScreensController < Admin::BaseController
  before_action :set_theater
  before_action :set_screen, only: %i[show edit update destroy]

  def index
    @screens = @theater.screens.includes(:shows)
    @shows = @theater.shows
    @bookings = Booking.joins(screening: :screen).where(screens: { theater_id: @theater.id })
    @feedbacks = @theater.feedbacks

    @current_week_bookings_by_screen = @bookings.where(booking_date: Time.current.beginning_of_week..Time.current.end_of_week).joins(screening: :screen).group('screens.screen_no').count

    @bookings_by_week = @bookings.where(booking_date: Time.current.beginning_of_week..Time.current.end_of_week)
                                 .group_by_day(:booking_date)
                                 .count

    @bookings_by_month = @bookings.where(booking_date: Time.current.beginning_of_month..Time.current.end_of_month)
                                  .group_by_day(:booking_date)
                                  .count

    @popular_shows = @bookings.joins(screening: :show).group('shows.name').count
  end

  def show; end

  def new
    @screen = Screen.new
  end

  def create
    @screen = Screen.new(screen_params)

    respond_to do |format|
      if @screen.save
        format.html { redirect_to admin_screen_url(@screen), notice: 'Screen was successfully created.' }
        format.json { render :show, status: :created, location: @screen }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @screen.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @screen.update(screen_params)
        format.html { redirect_to admin_screen_url(@screen), notice: 'Screen was successfully updated.' }
        format.json { render :show, status: :ok, location: @screen }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @screen.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @screen.destroy!

    respond_to do |format|
      format.html { redirect_to admin_root_url, notice: 'Screen was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # getting admin's assigned theater
  def set_theater
    @theater_admin = TheaterAdmin.where(user: current_user).first
    if @theater_admin.nil?
      redirect_to root_path, alert: 'You are not assigned to any theater'
    else
      @theater = @theater_admin.theater
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_screen
    @screen = Screen.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def screen_params
    params.require(:screen).permit(:screen_no, :seats, :status, :theater_id)
  end
end

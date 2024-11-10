class Admin::ScreensController < Admin::BaseController
  before_action :set_theater
  before_action :set_screen, only: %i[show edit update destroy]

  def index
    @screens = @theater.screens

    @screen_shows = Show.active.joins(screenings: :screen).where(screens: { theater_id: @theater.id }).distinct

    @show_screening_details = @screen_shows.map do |show|
      screenings = show.screenings.includes(:screen).where(screens: { theater_id: @theater.id })
      { show:, screenings: }
    end

    @bookings = Booking.confirmed.joins(screening: :screen).where(screens: { theater_id: @theater.id })

    @current_week_bookings_by_screen = @bookings.where(booking_date: Time.current.beginning_of_week..Time.current.end_of_week).joins(screening: :screen).group('screens.screen_name').count

    @bookings_by_week = @bookings.where(booking_date: Time.current.beginning_of_week..Time.current.end_of_week)
                                 .group_by_day(:booking_date)
                                 .count

    @bookings_by_month = @bookings.where(booking_date: Time.current.beginning_of_month..Time.current.end_of_month)
                                  .group_by_day(:booking_date)
                                  .count

    @popular_shows = @bookings.joins(screening: :show).group('shows.name').count

    @feedbacks = @theater.feedbacks.includes([:user])
  end

  def show
    @screen_screenings = @screen.screenings.includes(:show)
  end

  def new
    @screen = Screen.new
  end

  def create
    @screen = Screen.new(screen_params)
    authorize @screen

    if @screen.save
      redirect_to admin_screen_url(@screen), notice: 'Screen was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    authorize @screen
    if @screen.update(screen_params)
      redirect_to admin_screen_url(@screen), notice: 'Screen was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @screen
    @screen.destroy!
    redirect_to admin_root_url, notice: 'Screen was successfully destroyed.'
  end

  def switch_theater
    theater = Theater.find(params[:theater_id])
    if current_user.theaters.include?(theater)
      session[:current_theater] = theater.id
      redirect_to admin_root_path, notice: 'Switched theater successfully.'
    else
      redirect_to admin_root_path, alert: 'You do not have access to this theater.'
    end
  end

  private

  # getting admin's assigned theater
  def set_theater
    if session[:current_theater]
      @theater = current_user.theaters.find_by(id: session[:current_theater])
      redirect_to root_path, alert: 'Selected theater not found or you do not have access.' unless @theater
    else
      @theater = current_user.theaters.first
      session[:current_theater] = @theater.id if @theater
    end
  end

  def set_screen
    @screen = Screen.find(params[:id])
  end

  def screen_params
    params.require(:screen).permit(:screen_name, :seats, :status).merge(theater: @theater)
  end
end

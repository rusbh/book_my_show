class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_screening

  def new
    @booking = @screening.bookings.new
    authorize @booking
  end

  def create
    @booking = @screening.bookings.new(booking_params)
    @booking.user = current_user
    @booking.booking_date = @booking.show_timing.at_timeof
    authorize @booking

    if @booking.save
      @booking.send_booking_confirmed
      redirect_to profile_path, notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_screening
    @screening = Screening.find(params[:screening_id])
  end

  def booking_params
    params.require(:booking).permit(:ticket, :booking_date, :show_timing_id, :status, :screening_id)
  end
end

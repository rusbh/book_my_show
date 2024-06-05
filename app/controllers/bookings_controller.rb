class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_screening

  def new
    @booking = @screening.bookings.new
  end

  def create
    @booking = @screening.bookings.new(booking_params)
    @booking.user = current_user

    if @booking.save
      @booking.send_booking_confirmed
      redirect_to profile_path, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  private

  def set_screening
    @screening = Screening.find(params[:screening_id])
  end

  def booking_params
    params.require(:booking).permit(:ticket, :booking_date, :status, :screening_id)
  end
end

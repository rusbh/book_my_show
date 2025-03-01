class BookingMailer < ApplicationMailer
  def booking_confirmation(booking)
    @booking = booking

    mail(to: @booking.user.email, subject: "Booking Confirmation")
  end

  def booking_cancelled(booking)
    @booking = booking

    mail(to: @booking.user.email, subject: "Booking Cancelled")
  end

  def booking_deleted_unexpected(booking)
    @booking = booking

    mail(to: @booking.user.email, subject: "Booking unexpectedly got cancelled")
  end
end

class BookingMailer < ApplicationMailer

  def booking_confirmation(booking)
    @booking = booking

    mail to: @booking.user.email, subject: 'Booking Confirmation'
  end
  
end

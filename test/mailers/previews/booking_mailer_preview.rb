# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview
  def booking_confirmation
    BookingMailer.booking_confirmation(Booking.first)
  end
end

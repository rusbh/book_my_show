# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def admin_request
    details = { user_name: 'Admin', user_email: 'admin@rajhans.com', phone_no: '1234567890',
                theater_name: 'Rajhans Cinema, Vastral', theater_details: 'dsad' }
    AdminMailer.admin_request(details)
  end

  def invitation
    AdminMailer.invitation(User.first, SecureRandom.base36)
  end
end

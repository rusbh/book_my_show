# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def admin_request
    details = { contact_email: 'admin@rajhans.com', contact_no: '1234567890' }
    AdminMailer.admin_request(details)
  end

  def admin_invitation
    AdminMailer.admin_invitation(User.first, SecureRandom.base36)
  end
end

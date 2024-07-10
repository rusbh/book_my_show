# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def admin_request
    AdminMailer.admin_request(AdminRequest.last)
  end

  def admin_request_approved
    contact_email = 'approved@rajhans.com'
    AdminMailer.admin_request_approved(contact_email)
  end

  def admin_request_rejected
    contact_email = 'rejected@rajhans.com'
    AdminMailer.admin_request_rejected(contact_email)
  end

  def admin_invitation
    AdminMailer.admin_invitation(User.first, SecureRandom.base36)
  end
end

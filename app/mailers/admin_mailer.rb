class AdminMailer < ApplicationMailer
  def admin_request(admin_request)
    @admin_request = admin_request
    mail to: "superadmin@bms.com", subject: "New admin request for BMS theater portal"
  end

  def admin_request_approved(contact_email)
    @contact_email = contact_email
    mail to: @contact_email, subject: "Your Theater request has been approved"
  end

  def admin_request_rejected(contact_email)
    @contact_email = contact_email
    mail to: @contact_email, subject: "Your Theater request has been rejected"
  end

  def admin_invitation(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: "Welcome to BMS Theater Portal")
  end
end

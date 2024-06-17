class AdminMailer < ApplicationMailer
  def admin_request(admin_details)
    @admin_details = admin_details
    mail to: 'superadmin@bms.com', subject: "New admin request for BMS theater portal"
  end

  def admin_invitation(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: "Welcome to BMS Theater Portal")
  end
end

class AdminRequestJob
  include Sidekiq::Job

  def perform(admin_request_id)
    admin_request = AdminRequest.find(admin_request_id)

    theater_name = admin_request.theater_name
    theater_address = admin_request.theater_address
    theater_pincode = admin_request.pincode
    admin_emails = admin_request.admin_emails.split(',').map(&:strip)

    # create theatre
    theater = Theater.create!(name: theater_name, address: theater_address, pincode: theater_pincode, status: :inactive)

    # create user & theater admin
    admin_emails.each do |email|
      user = User.create!(name: 'user', email:, password: SecureRandom.base36, role: :admin, status: :inactive)
      TheaterAdmin.create!(theater:, user:, status: :inactive)
    end

    AdminMailer.admin_request(admin_request).deliver_later
  end
end

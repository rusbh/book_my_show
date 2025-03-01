class AdminRequestJob
  include Sidekiq::Job

  def perform(admin_request_id)
    admin_request = AdminRequest.find(admin_request_id)

    theater_name = admin_request.theater_name
    theater_address = admin_request.theater_address
    theater_pincode = admin_request.pincode
    admin_emails = admin_request.admin_emails.split(",").map(&:strip)

    # create theatre
    ActiveRecord::Base.transaction do
      theater = Theater.create!(
        name: theater_name,
        address: theater_address,
        pincode: theater_pincode,
        status: :inactive,
      )

      admin_emails.each do |email|
        user = User.find_by(email:)
        if user.present?
          user.update!(admin: true, status: :inactive)
        else
          admin = User.create!(name: "admin", email:, password: SecureRandom.base36, admin: true, status: :inactive)
        end
        TheaterAdmin.create!(theater:, admin:, status: :active)
      end
    end

    AdminMailer.admin_request(admin_request).deliver_later
  end
end

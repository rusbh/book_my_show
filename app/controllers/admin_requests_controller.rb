class AdminRequestsController < ApplicationController
  def new
    @admin_request = AdminRequest.new
  end

  def create
    @admin_request = AdminRequest.new(admin_request_params)

    if @admin_request.save
      AdminRequestJob.perform_async(@admin_request.id)
      redirect_to(
        root_path,
        notice: "Thank you for submitting the form, We will contact you details soon",
      )
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  private

  def set_admin_request
    @admin_request = AdminRequest.find(params[:id])
  end

  def admin_request_params
    params.expect(admin_request: [
      :contact_email,
      :contact_no,
      :admin_emails,
      :theater_name,
      :theater_address,
      :pincode,
      :business_license,
      :ownership_proof,
      :noc,
      :insurance,
      :status,
    ])
  end
end

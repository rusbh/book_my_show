class AdminRequestsController < ApplicationController
  def new
    @admin_request = AdminRequest.new
  end

  def create
    @admin_request = AdminRequest.new(admin_request_params)

    respond_to do |format|
      if @admin_request.save
        AdminRequestJob.perform_async(@admin_request.id)
        format.html do
          redirect_to root_path, notice: 'Thank you for submitting the form, We will contact you details soon'
        end
        format.json { render :show, status: :created, location: @admin_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_request.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_admin_request
    @admin_request = AdminRequest.find(params[:id])
  end

  def admin_request_params
    params.require(:admin_request).permit(:contact_email, :contact_no, :admin_emails, :theater_name,
                                          :theater_address, :pincode, :business_license, :ownership_proof, :noc, :insurance, :status)
  end
end

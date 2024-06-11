class UsersController < ApplicationController
  def index
    authorize current_user
    @past_bookings = current_user.past_bookings
    @upcoming_bookings = current_user.upcoming_bookings
    @cancelled_bookings = current_user.cancelled_bookings
  end

  def theater_inquiry; end

  def theater_inquiry_details
    @admin_details = params.permit(:user_name, :user_email, :phone_no, :theater_name, :theater_details)

    if @admin_details[:user_name].present? && @admin_details[:user_email].present? && @admin_details[:phone_no].present? && @admin_details[:theater_name].present? && @admin_details[:theater_details].present?
      AdminMailer.admin_request(@admin_details).deliver_later
      flash[:notice] = 'Thank you for submitting the form, We will contact you to verify details soon'
      redirect_to root_path
    else
      flash[:alert] = 'All fields are required.'
      render 'users/theater_inquiry', status: :unprocessable_entity
    end
  end
end

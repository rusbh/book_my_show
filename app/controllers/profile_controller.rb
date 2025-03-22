class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    authorize(current_user)
    @past_bookings = current_user.past_bookings
    @upcoming_bookings = current_user.upcoming_bookings
    @cancelled_bookings = current_user.cancelled_bookings
  end

  def change_avatar
    avatar = params.fetch(:avatar)
    current_user.update(avatar: avatar)
    redirect_to(profile_path, notice: "Avatar updated successfully!")
  end
end

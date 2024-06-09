class UsersController < ApplicationController
  def index
    authorize current_user
    @past_bookings = current_user.past_bookings
    @upcoming_bookings = current_user.upcoming_bookings
    @cancelled_bookings = current_user.cancelled_bookings
  end
end

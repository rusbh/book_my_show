class Admin::DashboardController < Admin::BaseController
  before_action :set_theater

  def index
    @screens = @theater.screens.all
  end

  private

  # getting admin's assigned theater
  def set_theater
    @theater_admin = TheaterAdmin.where(user: current_user).first
    @theater = @theater_admin.theater
  end
end

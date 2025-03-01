class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  protect_from_forgery with: :exception
  include ApplicationHelper
  include Pundit::Authorization
  include Pagy::Backend

  rescue_from ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, with: :not_found_method
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # rescue_from NoMethodError, with: :handle_no_method_error

  before_action :configure_permitted_parameters, if: :devise_controller?

  def not_found_method
    render(file: Rails.public_path.join("404.html"), status: :not_found, layout: false)
  end

  http_basic_authenticate_with name: ENV.fetch("SUPERADMIN_USERNAME"),
    password: ENV.fetch("SUPERADMIN_PASSWORD"),
    if: :active_admin_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :status])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :status])
  end

  private

  def active_admin_controller?
    self.class < ActiveAdmin::BaseController
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def handle_no_method_error(exception)
    flash[:alert] = exception.message || "Oops! Something went wrong."
    redirect_back(fallback_location: root_path)
  end

  # devise method for redirecting admin to theater portal after login
  def after_sign_in_path_for(resource)
    if resource&.admin? && resource.active? && TheaterAdmin.find_by(admin: resource)&.active?
      admin_root_path
    elsif resource&.admin? && TheaterAdmin.find_by(admin: resource)&.inactive?
      sign_out(resource)
      flash[:error] = "You can't access the Theater Admin Panel, Contact Support for details"
      root_path
    elsif resource&.inactive?
      sign_out(resource)
      flash[:error] = "You can't login to application due to some reasons, Contact Support for details"
      root_path
    else
      super
    end
  end
end

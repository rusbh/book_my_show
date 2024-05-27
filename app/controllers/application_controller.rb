class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  http_basic_authenticate_with name: Rails.application.credentials.dig(:superadmin, :username),
                               password: Rails.application.credentials.dig(:superadmin, :password),
                               if: :active_admin_controller?

  def active_admin_controller?
    self.class < ActiveAdmin::BaseController
  end

  protected

  # devise method for redirecting admin to theater page after login
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    else
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end

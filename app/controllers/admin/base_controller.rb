class Admin::BaseController < ApplicationController
  before_action :restrict_non_admin

  protected

  def restrict_non_admin
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "You are not authorized to visit that page, Contact Support"
    end
  end
end
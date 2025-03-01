module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :restrict_non_admin
    layout "admin/layout"

    protected

    def restrict_non_admin
      return if current_user&.admin?

      redirect_to(root_path, alert: "You are not authorized to visit that page, Contact Support")
    end
  end
end

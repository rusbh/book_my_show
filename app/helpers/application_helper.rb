module ApplicationHelper
  def theater_portal_path
    admin_root_path(TheaterAdmin.where(user: current_user).first.theater)
  end
end

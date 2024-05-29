module ApplicationHelper
  def theater_portal_path
    admin_root_path(TheaterAdmin.where(user: current_user).first.theater)
  end

  def formatted_duration(time)
    hours = time / 60
    minutes = time % 60
    if minutes == 0
      "#{hours} hours"
    elsif hours == 0
      "#{minutes} minutes"
    else
      "#{hours}h #{minutes}m"
    end
  end
end

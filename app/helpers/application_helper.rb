module ApplicationHelper
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

  def format_date(date)
    date.strftime("%d %B, %Y")
  end
end

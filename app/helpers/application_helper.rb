module ApplicationHelper
  include Pagy::Frontend
  
  def full_title(page_title = "")
    base_title = "BookMyShow"
    page_title.empty? ? base_title : page_title + " | " + base_title
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

  def format_date(date)
    date.strftime("%d %B, %Y")
  end

  def format_time(time)
    time.strftime("%I:%M %p")
  end

  def format_datetime(datetime)
    datetime.strftime("%d %B, %y at %I:%M %p")
  end
end

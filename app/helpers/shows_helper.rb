module ShowsHelper
  def display_show_poster(show, hover: false)
    classes = "rounded-lg"
    classes += " hover:scale-105 cursor-pointer transition" if hover

    if show.poster.attached?
      image_tag url_for(show.poster.variant(:display)), class: classes
    else
      image_tag "poster.png", class: classes, size: "226x226"
    end
  end
end

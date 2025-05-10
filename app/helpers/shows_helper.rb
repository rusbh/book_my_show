module ShowsHelper
  def display_show_poster(show, hover: false)
    classes = class_names(
      "rounded-lg",
      "hover:scale-105 cursor-pointer transition": hover,
    )

    image_tag(
      show.poster.attached? ? url_for(show.poster.variant(:display)) : "placeholder.png",
      class: classes,
    )
  end
end

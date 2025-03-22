module UsersHelper
  def user_poster(user, classes, size)
    if user.avatar.attached?
      image_tag(user.avatar.variant(:display), class: classes)
    else
      inline_svg_tag("icons/outline/profile.svg", size: "#{size}*#{size}")
    end
  end
end

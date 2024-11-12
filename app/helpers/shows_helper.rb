module ShowsHelper
  def display_show_poster(show, hover: false)
    classes = class_names(
      'rounded-lg',
      'hover:scale-105 cursor-pointer transition': hover
    )

    content_tag :div, data: { controller: 'image-loader' } do
      concat image_tag('loader.png',
                       data: { image_loader_target: 'loader' })

      concat image_tag(
        show.poster.attached? ? url_for(show.poster.variant(:display)) : 'placeholder.png',
        class: "#{classes} hidden",
        data: { action: 'load->image-loader#showImage', image_loader_target: 'image' }
      )
    end
  end
end

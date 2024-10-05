ActiveAdmin.register EventRequest do
  remove_filter :poster_attachment, :poster_blob, :permits_attachments, :permits_blobs, :cpics_attachments, :cpics_blobs

  show do
    attributes_table do
      row :theater
      row :name
      row :description
      row :poster do |p|
        image_tag url_for(p.poster)
      end
      row :cast
      row :languages do |show|
        show.languages.join(', ')
      end
      row :genres do |show|
        show.genres.join(', ')
      end
      row :category
      row 'Duration of show (in Minutes)', &:duration
      row :release_date
      row :permits do |p|
        p.permits.each do |i|
          image_tag url_for(p)
        end
      end
      row :status
    end
  end

  form decorate: true do |f|
    f.inputs do
      f.input :theater
      f.input :name
      f.input :description
      f.input :poster, as: :file, input_html: { accept: 'image/jpeg, image/jpg, image/png' }
      f.input :cast, label: 'Cast: (add comma between entries)'
      f.input :languages, as: :check_boxes, collection: Show.languages.keys.map { |lang| [lang.humanize, lang] }
      f.input :genres, as: :check_boxes, collection: Show.genres.keys.map { |lang| [lang.humanize, lang] }
      f.input :category
      f.input :duration, label: 'Duration of show (in Minutes)'
      f.input :release_date
      f.input :permits, as: :file, input_html: { accept: 'image/jpeg, image/jpg, image/png', multiple: true }
      f.input :status
    end
    f.actions
  end

  permit_params :theater_id, :name, :description, :poster, :cast, :category, :duration, :release_date, :status,
                languages: [], genres: [], permits: []
end

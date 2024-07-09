ActiveAdmin.register Show do
  remove_filter :poster_attachment, :poster_blob, :cpics_attachments, :cpics_blobs

  show do
    attributes_table do
      row :name
      row :description
      row :poster do |p|
        display_show_poster(p)
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
      row :status
    end
  end

  form decorate: true do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :poster, as: :file, input_html: { accept: 'image/jpeg, image/jpg, image/png' }
      f.input :cast, label: 'Cast: (add comma between entries)'
      f.input :languages, as: :check_boxes, collection: Show.languages.keys.map { |lang| [lang.humanize, lang] }
      f.input :genres, as: :check_boxes, collection: Show.genres.keys.map { |lang| [lang.humanize, lang] }
      f.input :category
      f.input :duration, label: 'Duration of show (in Minutes)'
      f.input :release_date
      f.input :slug, label: 'name helper for url' unless f.object.new_record?
      f.input :status
    end
    f.actions
  end

  permit_params :name, :description, :poster, :cast, :category, :status, :duration, :release_date, :slug,
                languages: [], genres: []
end

ActiveAdmin.register Show do
  remove_filter :poster_attachment, :poster_blob, :cpics_attachments, :cpics_blobs

  show do
    attributes_table do
      row :name
      row :description
      row :poster do |p|
        if p.poster.attached?
          image_tag url_for(p.poster)
        end
      end
      row :cast
      row :language
      row :genre
      row :category
      row :imdb_rating
      row :status
      row :duration
      row :release_date
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :poster, as: :file
      f.input :cast
      f.input :language
      f.input :genre
      f.input :category
      f.input :imdb_rating
      f.input :status
      f.input :duration
      f.input :release_date
    end
    f.actions
  end

  permit_params :name, :description, :poster, :cast, :language, :genre, :category, :imdb_rating, :status, :duration, :release_date
end

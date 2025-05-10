ActiveAdmin.register(EventRequest) do
  remove_filter :poster_attachment,
                :poster_blob,
                :permit_attachment,
                :permit_blob,
                :cpics_attachments,
                :cpics_blobs

  index do
    selectable_column
    id_column
    column :theater
    column :user do |t|
      link_to t.user.email, superadmin_user_path(t.user)
    end
    column :name
    column :description
    column :poster do |s|
      s.poster.filename
    end
    column :cast
    column :category
    column :duration
    column :release_date
    column :end_date
    column :at_timeof
    column :languages
    column :genres
    column :permit do |s|
      s.permit.filename
    end
    column :status
    column :created_at
    column :updated_at
    actions
  end

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
        show.languages.join(", ")
      end
      row :genres do |show|
        show.genres.join(", ")
      end
      row :category
      row "Duration of show (in Minutes)", &:duration
      row :release_date
      row :end_date
      row :at_timeof
      row :permit do |p|
        permit_preview = image_tag(url_for(p.permit.representation(resize: "500x500")))
        permit_link = link_to(
          "#{p.permit.filename} - Download",
          rails_blob_path(
            p.permit,
            disposition: "attachment",
          ),
        )
        raw("#{permit_preview} #{permit_link}")
      end
      row :status
    end
  end

  form decorate: true do |f|
    f.inputs do
      f.input(:theater)
      f.input(:name)
      f.input(:description)
      f.input(
        :poster,
        as: :file,
        input_html: { accept: "image/jpeg, image/jpg, image/png" },
      )
      f.input(:cast, label: "Cast: (add comma between entries)")
      f.input(:languages, as: :check_boxes, collection: Show.languages.keys.map do |lang|
        [lang.humanize, lang]
      end)
      f.input(:genres, as: :check_boxes, collection: Show.genres.keys.map do |lang|
        [lang.humanize, lang]
      end)
      f.input(:category)
      f.input(:duration, label: "Duration of show (in Minutes)")
      f.input(:release_date)
      f.input(:end_date)
      f.input(:at_timeof)
      f.input(:permit, as: :file)
      f.input(:status)
    end
    f.actions
  end

  permit_params :theater_id,
                :name,
                :description,
                :poster,
                :cast,
                :category,
                :duration,
                :release_date,
                :end_date,
                :at_timeof,
                :status,
                :permit,
                languages: [],
                genres: []
end

ActiveAdmin.register ScreenShow do
  form do |f|
    f.inputs do
      f.input :screen, as: :select, collection: Theater.first.screens.map { |s| [s.screen_no, s.id] }
      f.input :show
      f.input :start_date
      f.input :end_date
    end
    f.actions
  end

  permit_params :screen_id, :show_id, :start_date, :end_date
end

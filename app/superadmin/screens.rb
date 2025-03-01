ActiveAdmin.register Screen do
  permit_params :screen_name, :status, :theater_id

  form decorate: true do |f|
    f.inputs do
      f.input :theater, label: "Select Theater"
      f.input :screen_name
      f.input :seats
      f.input :status
    end
    f.actions
  end
end

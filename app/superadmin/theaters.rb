ActiveAdmin.register Theater do
  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :city_id, as: :select, collection: City.all.map { |c| [c.name, c.id] }
    end
    f.actions
  end

  permit_params :name, :address, :city_id
end

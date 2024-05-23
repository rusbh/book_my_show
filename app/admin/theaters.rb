ActiveAdmin.register Theater do
  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :city_id, as: :select, collection: City.all.map { |c| [c.name, c.id] }
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :address, :city_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :city_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

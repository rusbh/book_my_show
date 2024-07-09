ActiveAdmin.register Theater do
  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :pincode
      f.input :status
    end
    f.actions
  end

  permit_params :name, :address, :pincode, :status
end

ActiveAdmin.register(Theater) do
  remove_filter :action,
                :associated_id,
                :associated_type,
                :auditable_id,
                :auditable_type,
                :audited_changes,
                :comment,
                :created_at,
                :id,
                :remote_address,
                :request_uuid,
                :user_id,
                :user_type,
                :username,
                :version

  form do |f|
    f.inputs do
      f.input(:name)
      f.input(:address)
      f.input(:pincode)
      f.input(:status)
    end
    f.actions
  end

  permit_params :name, :address, :pincode, :status
end

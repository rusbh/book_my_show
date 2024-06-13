ActiveAdmin.register ShowTiming do
  index do
    column :at_time
    column :screening_id
    column :created_at
    column :updated_at
  end
  
  permit_params :at_timeof, :screening_id
end

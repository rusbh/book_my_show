class AddEventDataToEventRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :event_requests, :end_date, :date
  end
end

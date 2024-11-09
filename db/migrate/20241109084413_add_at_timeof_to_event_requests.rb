class AddAtTimeofToEventRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :event_requests, :at_timeof, :datetime
  end
end

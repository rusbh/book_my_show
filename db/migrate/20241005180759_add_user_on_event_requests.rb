class AddUserOnEventRequests < ActiveRecord::Migration[7.1]
  def change
    add_reference :event_requests, :user, foreign_key: true
  end
end

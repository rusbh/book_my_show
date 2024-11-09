class AddEventRequestsToShows < ActiveRecord::Migration[7.1]
  def change
    add_reference :shows, :event_request, foreign_key: true
  end
end

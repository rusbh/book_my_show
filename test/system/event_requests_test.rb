require "application_system_test_case"

class EventRequestsTest < ApplicationSystemTestCase
  setup do
    @event_request = event_requests(:one)
  end

  test "visiting the index" do
    visit event_requests_url
    assert_selector "h1", text: "Event requests"
  end

  test "should create event request" do
    visit event_requests_url
    click_on "New event request"

    fill_in "Cast", with: @event_request.cast
    fill_in "Category", with: @event_request.category
    fill_in "Description", with: @event_request.description
    fill_in "Duration", with: @event_request.duration
    fill_in "Genres", with: @event_request.genres
    fill_in "Languages", with: @event_request.languages
    fill_in "Name", with: @event_request.name
    fill_in "Release date", with: @event_request.release_date
    fill_in "Status", with: @event_request.status
    fill_in "Theater", with: @event_request.theater_id
    click_on "Create Event request"

    assert_text "Event request was successfully created"
    click_on "Back"
  end

  test "should update Event request" do
    visit event_request_url(@event_request)
    click_on "Edit this event request", match: :first

    fill_in "Cast", with: @event_request.cast
    fill_in "Category", with: @event_request.category
    fill_in "Description", with: @event_request.description
    fill_in "Duration", with: @event_request.duration
    fill_in "Genres", with: @event_request.genres
    fill_in "Languages", with: @event_request.languages
    fill_in "Name", with: @event_request.name
    fill_in "Release date", with: @event_request.release_date
    fill_in "Status", with: @event_request.status
    fill_in "Theater", with: @event_request.theater_id
    click_on "Update Event request"

    assert_text "Event request was successfully updated"
    click_on "Back"
  end

  test "should destroy Event request" do
    visit event_request_url(@event_request)
    click_on "Destroy this event request", match: :first

    assert_text "Event request was successfully destroyed"
  end
end

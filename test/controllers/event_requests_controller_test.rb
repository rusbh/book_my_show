require "test_helper"

class EventRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_request = event_requests(:one)
  end

  test "should get index" do
    get event_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_event_request_url
    assert_response :success
  end

  test "should create event_request" do
    assert_difference("EventRequest.count") do
      post event_requests_url, params: { event_request: { cast: @event_request.cast, category: @event_request.category, description: @event_request.description, duration: @event_request.duration, genres: @event_request.genres, languages: @event_request.languages, name: @event_request.name, release_date: @event_request.release_date, status: @event_request.status, theater_id: @event_request.theater_id } }
    end

    assert_redirected_to event_request_url(EventRequest.last)
  end

  test "should show event_request" do
    get event_request_url(@event_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_request_url(@event_request)
    assert_response :success
  end

  test "should update event_request" do
    patch event_request_url(@event_request), params: { event_request: { cast: @event_request.cast, category: @event_request.category, description: @event_request.description, duration: @event_request.duration, genres: @event_request.genres, languages: @event_request.languages, name: @event_request.name, release_date: @event_request.release_date, status: @event_request.status, theater_id: @event_request.theater_id } }
    assert_redirected_to event_request_url(@event_request)
  end

  test "should destroy event_request" do
    assert_difference("EventRequest.count", -1) do
      delete event_request_url(@event_request)
    end

    assert_redirected_to event_requests_url
  end
end

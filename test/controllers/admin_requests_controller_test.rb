require "test_helper"

class AdminRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_request = admin_requests(:one)
  end

  test "should get index" do
    get admin_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_request_url
    assert_response :success
  end

  test "should create admin_request" do
    assert_difference("AdminRequest.count") do
      post admin_requests_url, params: { admin_request: { admin_emails: @admin_request.admin_emails, contact_email: @admin_request.contact_email, contact_no: @admin_request.contact_no, pincode: @admin_request.pincode, status: @admin_request.status, theater_address: @admin_request.theater_address, theater_name: @admin_request.theater_name } }
    end

    assert_redirected_to admin_request_url(AdminRequest.last)
  end

  test "should show admin_request" do
    get admin_request_url(@admin_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_request_url(@admin_request)
    assert_response :success
  end

  test "should update admin_request" do
    patch admin_request_url(@admin_request), params: { admin_request: { admin_emails: @admin_request.admin_emails, contact_email: @admin_request.contact_email, contact_no: @admin_request.contact_no, pincode: @admin_request.pincode, status: @admin_request.status, theater_address: @admin_request.theater_address, theater_name: @admin_request.theater_name } }
    assert_redirected_to admin_request_url(@admin_request)
  end

  test "should destroy admin_request" do
    assert_difference("AdminRequest.count", -1) do
      delete admin_request_url(@admin_request)
    end

    assert_redirected_to admin_requests_url
  end
end

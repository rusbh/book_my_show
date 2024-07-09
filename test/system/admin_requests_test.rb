require "application_system_test_case"

class AdminRequestsTest < ApplicationSystemTestCase
  setup do
    @admin_request = admin_requests(:one)
  end

  test "visiting the index" do
    visit admin_requests_url
    assert_selector "h1", text: "Admin requests"
  end

  test "should create admin request" do
    visit admin_requests_url
    click_on "New admin request"

    fill_in "Admin emails", with: @admin_request.admin_emails
    fill_in "Contact email", with: @admin_request.contact_email
    fill_in "Contact no", with: @admin_request.contact_no
    fill_in "Pincode", with: @admin_request.pincode
    fill_in "Status", with: @admin_request.status
    fill_in "Theater address", with: @admin_request.theater_address
    fill_in "Theater name", with: @admin_request.theater_name
    click_on "Create Admin request"

    assert_text "Admin request was successfully created"
    click_on "Back"
  end

  test "should update Admin request" do
    visit admin_request_url(@admin_request)
    click_on "Edit this admin request", match: :first

    fill_in "Admin emails", with: @admin_request.admin_emails
    fill_in "Contact email", with: @admin_request.contact_email
    fill_in "Contact no", with: @admin_request.contact_no
    fill_in "Pincode", with: @admin_request.pincode
    fill_in "Status", with: @admin_request.status
    fill_in "Theater address", with: @admin_request.theater_address
    fill_in "Theater name", with: @admin_request.theater_name
    click_on "Update Admin request"

    assert_text "Admin request was successfully updated"
    click_on "Back"
  end

  test "should destroy Admin request" do
    visit admin_request_url(@admin_request)
    click_on "Destroy this admin request", match: :first

    assert_text "Admin request was successfully destroyed"
  end
end

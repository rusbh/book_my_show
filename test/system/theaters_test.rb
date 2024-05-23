require "application_system_test_case"

class TheatersTest < ApplicationSystemTestCase
  setup do
    @theater = theaters(:one)
  end

  test "visiting the index" do
    visit theaters_url
    assert_selector "h1", text: "Theaters"
  end

  test "should create theater" do
    visit theaters_url
    click_on "New theater"

    fill_in "Address", with: @theater.address
    fill_in "City", with: @theater.city_id
    fill_in "Name", with: @theater.name
    click_on "Create Theater"

    assert_text "Theater was successfully created"
    click_on "Back"
  end

  test "should update Theater" do
    visit theater_url(@theater)
    click_on "Edit this theater", match: :first

    fill_in "Address", with: @theater.address
    fill_in "City", with: @theater.city_id
    fill_in "Name", with: @theater.name
    click_on "Update Theater"

    assert_text "Theater was successfully updated"
    click_on "Back"
  end

  test "should destroy Theater" do
    visit theater_url(@theater)
    click_on "Destroy this theater", match: :first

    assert_text "Theater was successfully destroyed"
  end
end

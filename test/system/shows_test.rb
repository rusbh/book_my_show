require "application_system_test_case"

class ShowsTest < ApplicationSystemTestCase
  setup do
    @show = shows(:one)
  end

  test "visiting the index" do
    visit shows_url
    assert_selector "h1", text: "Shows"
  end

  test "should create show" do
    visit shows_url
    click_on "New show"

    fill_in "Cast", with: @show.cast
    fill_in "Category", with: @show.category
    fill_in "Description", with: @show.description
    fill_in "Duration", with: @show.duration
    fill_in "End date", with: @show.end_date
    fill_in "Genre", with: @show.genre
    fill_in "Imdb rating", with: @show.imdb_rating
    fill_in "Language", with: @show.language
    fill_in "Name", with: @show.name
    fill_in "Price", with: @show.price
    fill_in "Start date", with: @show.start_date
    fill_in "Status", with: @show.status
    click_on "Create Show"

    assert_text "Show was successfully created"
    click_on "Back"
  end

  test "should update Show" do
    visit show_url(@show)
    click_on "Edit this show", match: :first

    fill_in "Cast", with: @show.cast
    fill_in "Category", with: @show.category
    fill_in "Description", with: @show.description
    fill_in "Duration", with: @show.duration
    fill_in "End date", with: @show.end_date
    fill_in "Genre", with: @show.genre
    fill_in "Imdb rating", with: @show.imdb_rating
    fill_in "Language", with: @show.language
    fill_in "Name", with: @show.name
    fill_in "Price", with: @show.price
    fill_in "Start date", with: @show.start_date
    fill_in "Status", with: @show.status
    click_on "Update Show"

    assert_text "Show was successfully updated"
    click_on "Back"
  end

  test "should destroy Show" do
    visit show_url(@show)
    click_on "Destroy this show", match: :first

    assert_text "Show was successfully destroyed"
  end
end

require "application_system_test_case"

class DropsTest < ApplicationSystemTestCase
  setup do
    @drop = drops(:one)
  end

  test "visiting the index" do
    visit drops_url
    assert_selector "h1", text: "Drops"
  end

  test "should create drop" do
    visit drops_url
    click_on "New drop"

    fill_in "Description", with: @drop.description
    fill_in "Project", with: @drop.project_id
    fill_in "Title", with: @drop.title
    click_on "Create Drop"

    assert_text "Drop was successfully created"
    click_on "Back"
  end

  test "should update Drop" do
    visit drop_url(@drop)
    click_on "Edit this drop", match: :first

    fill_in "Description", with: @drop.description
    fill_in "Project", with: @drop.project_id
    fill_in "Title", with: @drop.title
    click_on "Update Drop"

    assert_text "Drop was successfully updated"
    click_on "Back"
  end

  test "should destroy Drop" do
    visit drop_url(@drop)
    click_on "Destroy this drop", match: :first

    assert_text "Drop was successfully destroyed"
  end
end

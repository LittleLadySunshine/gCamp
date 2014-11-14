require 'rails_helper'

feature "Tasks" do

  scenario "User creates a Tasks" do
    visit tasks_path
    expect(page).to have_no_content("My awesome task")
    click_on "Create Task"
    fill_in "Description", with: "My awesome tasks"
    fill_in "Due date", with: "11/01/14"
    click_on "Create Task"

    expect(page).to have_content("My awesome task")
  end

  scenario "User edits a Task" do

    visit tasks_path
    # expect(page).to have_content("My awesome task")
    expect(page).to have_no_content("My awesome task")
    click_on "Create Task"
    fill_in "Description", with: "My awesome tasks"
    fill_in "Due date", with: "11/01/14"
    click_on "Create Task"


    expect(page).to have_content("My awesome task")
    click_on "Edit"
    fill_in "Description", with: "My aweeeesome tasks"
    fill_in "Due date", with: "11/01/14"
    click_on "Update Task"

    expect(page).to have_content("My aweeeesome tasks")
    expect(page).to have_no_content("My awesome task")
  end

  scenario "User destroys a Task" do
    visit tasks_path
    # expect(page).to have_content("My awesome task")
    expect(page).to have_no_content("My awesome task")
    click_on "Create Task"
    fill_in "Description", with: "My awesome tasks"
    fill_in "Due date", with: "11/01/14"
    click_on "Create Task"


    expect(page).to have_content("My awesome task")
    click_on "Destroy"
    expect(page).to have_no_content("My awesome task")
  end
end

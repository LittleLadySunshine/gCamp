require 'rails_helper'

feature "Tasks" do

  scenario "User creates a Task" do
    visit projects_path
    expect(page).to have_no_content("My awesome task")
    click_on "Create Project"
    fill_in "Name", with: "new project"
    click_on "Create Project"
    click_on "0 Tasks"
    click_on "Create Task"
    fill_in "Description", with: "My awesome task"
    fill_in "Due date", with: "12/31/2014"
    click_on "Create Task"

    expect(page).to have_content("My awesome task")
    expect(page).to have_content("Task was successfully created.")
  end

  scenario "User edits a Task" do
    visit projects_path
    click_on "My awesome task"
    click_on "1 Task"
    click_on "Edit"
    fill_in "Description", with: "my aweeesome task"
    fill_in "Due date", with: "12/31/15"
    click_on "Update Task"

    expect(page).to have_content("my aweeesome task")
  end
  #
  #
  #   expect(page).to have_content("My awesome task")
  #   click_on "Edit"
  #   fill_in "Description", with: "My aweeeesome tasks"
  #   fill_in "Due date", with: "11/01/14"
  #   click_on "Update Task"
  #
  #   expect(page).to have_content("My aweeeesome tasks")
  #   expect(page).to have_no_content("My awesome task")
  # end
  #
  # scenario "User destroys a Task" do
  #   visit project_tasks_path
  #   # expect(page).to have_content("My awesome task")
  #   expect(page).to have_no_content("My awesome task")
  #   click_on "Create Task"
  #   fill_in "Description", with: "My awesome tasks"
  #   fill_in "Due date", with: "11/01/14"
  #   click_on "Create Task"
  #
  #
  #   expect(page).to have_content("My awesome task")
  #   click_on "Destroy"
  #   expect(page).to have_no_content("My awesome task")
  # end
end

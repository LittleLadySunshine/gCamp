require 'rails_helper'

feature "Project" do

  scenario "User creates a project" do
    visit projects_path
    expect(page).to have_no_content("My awesome name")
    click_on "Create Project"
    fill_in "Name", with: "My awesome name"
    click_on "Create Project"

    expect(page).to have_content("My awesome name")
  end
end

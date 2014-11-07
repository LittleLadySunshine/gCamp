require 'rails_helper'

feature "signup" do

  scenario "checks successful signup" do
    visit users_path
    expect(page).to have_no_content("Scooby")
    expect(page).to have_no_content("Doo")
    expect(page).to have_no_content("ScoobyDoo@example.com")
    User.create!(first_name: "Scooby", last_name: "Doo",
      email: "ScoobyDoo@example.com", password: "test",
      password_confirmation: "test")
    visit users_path
    expect(page).to have_content("Scooby")
    expect(page).to have_content("Doo")
    expect(page).to have_content("ScoobyDoo@example.com")
    click_on "Edit"
    fill_in "First name", with: "Scuby"
    click_on "Update User"
    click_on "Edit"
    click_on "Destroy"
    expect(page).to have_no_content("Doo")
    expect(page).to have_no_content("ScoobyDoo@example.com")
  end

end

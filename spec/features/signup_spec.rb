require 'rails_helper'

  feature "signup" do
  background do
    User.create(:first_name => 'Aaron', :last_name => 'Gray', :email => 'aaron@example.com', :password => 'caplin')
  end

  scenario "checks successful signup" do
    visit users_path
    expect(page).to have_no_content("Scooby")
    expect(page).to have_no_content("Doo")
    expect(page).to have_no_content("ScoobyDoo@example.com")
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Scooby"
    fill_in "Last name", with: "Doo"
    fill_in "Email", with: "ScoobyDoo.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Create User"
    click_on "Sign Out"
    visit users_path
    expect(page).to have_content("Scooby")
    expect(page).to have_content("Doo")

  end

  scenario "checks blank password_and_email" do
    visit users_path
    click_on "Create User"
    expect(page).to have_no_content("Email can't be blank")
    expect(page).to have_no_content("Password can't be blank")
    click_on "Create User"
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  scenario "checks blank password" do
    visit users_path
    click_on "Create User"
    expect(page).to have_no_content("Password can't be blank")
    fill_in "First name", with: "Scooby"
    fill_in "Last name", with: "Doo"
    fill_in "Email", with: "ScoobyDoo@example.com"
    click_on "Create User"
    expect(page).to have_content("Password can't be blank")
  end
end

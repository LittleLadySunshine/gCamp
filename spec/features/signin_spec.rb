# require 'rails_helper'
#
# feature "signup" do
#   background do
#     User.create(:first_name => 'Aaron', :last_name => 'Gray',
#     :email => 'aaron@example.com', :password => 'caplin')
#   end
#
#   scenario "creates a user" do
#     visit users_path
#     expect(page).to have_no_content("Scooby")
#     expect(page).to have_no_content("Doo")
#     expect(page).to have_no_content("ScoobyDoo@example.com")
#     click_on "Create User"
#     fill_in "First name", with: "Scooby"
#     fill_in "Last name", with: "Doo"
#     fill_in "Email", with: "ScoobyDoo@example.com"
#     fill_in "Password", with: "password"
#     fill_in "Password confirmation", with: "password"
#     click_on "Create User"
#     expect(page).to have_content("Scooby")
#     expect(page).to have_content("Doo")
#     expect(page).to have_content("ScoobyDoo@example.com")
#   end
#
#
#
#   scenario "Signing in with correct credentials" do
#     visit '/sign-in'
#     expect(page).to have_content("Sign In")
#       fill_in "Email", with: "aaron@example.com"
#       fill_in "Password", with: "caplin"
#     click_on "Sign in"
#   end
#
#
#   scenario "edits a user" do
#     visit users_path
#     expect(page).to have_content("Aaron")
#     expect(page).to have_content("Gray")
#     expect(page).to have_content("aaron@example.com")
#     click_on "Edit"
#       fill_in "First name", with: "Scuby"
#       fill_in "Last name", with: "Dud"
#       fill_in "Email", with: "ScubyDud@example.com"
#       click_on "Update User"
#       expect(page).to have_no_content("Scooby")
#     expect(page).to have_no_content("Doo")
#     expect(page).to have_no_content("ScoobyDoo@example.com")
#     expect(page).to have_content("Scuby")
#     expect(page).to have_content("Dud")
#     expect(page).to have_content("ScubyDud@example.com")
#   end
#
#     scenario "signing in with invalid credentials" do
#     visit '/sign-in'
#     expect(page).to have_content("Sign In")
#       fill_in "Email", with: " "
#       fill_in "Password", with: " "
#       click_on "Sign in"
#     expect(page).to have_content("Username / password combination is invalid")
#   end
# end

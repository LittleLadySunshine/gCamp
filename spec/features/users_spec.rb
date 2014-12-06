# require 'rails_helper'
#
# feature "tasks" do
#
#   scenario "create user do" do
#     visit home_path
#     click_on "Users"
#     click_on "Create User"
#     fill_in "First name", with: "Scooby"
#     fill_in "Last name", with: "Doo"
#     fill_in "Email", with: "Scooby@example.com"
#     fill_in "Password", with: "1234"
#     fill_in "Password confirmation", with: "1234"
#     click_on "Create User"
#
#     # verify user and attributes exist index
#     expect(page).to have_content("User was successfully created")
#     expect(page).to have_content("Scooby")
#     expect(page).to have_content("Doo")
#     expect(page).to have_content("Scooby@example.com")
#
#     # verify user exist on show page
#     click_on "test testing"
#     expect(page).to have_no_content("User was successfully created.")
#     expect(page).to have_content("First name: Scooby")
#     expect(page).to have_content("Last name: Doo")
#     expect(page).to have_content("Email: Scooby@example.com")
#
#     # edit user
#     click_on "Edit"
#     fill_in "First name", with: "Joe"
#     fill_in "Last name", with: "Schmo"
#     fill_in "Email", with: "JoeSchmo@example.com"
#     fill_in "Password", with: "1234"
#     fill_in "Password confirmation", with: "1234"
#     click_on "Update User"
#
#     # verify alterations were saved and exist on the index
#     expect(page).to have_content("User was successfully updated.")
#     expect(page).to have_content("Joe")
#     expect(page).to have_content("Schmo")
#     expect(page).to have_content("JoeSchmo@example.com")
#
# end
#
#
# end

require 'rails_helper'

# feature 'User signs in' do
#   scenario 'with valid email and password' do
#
#       visit root_path
#     expect(page).to have_content("Sign In")
#     click_on "sign in"
#     fill_in "Email", with: "Email@example.com"
#     fill_in "Password", with: "1234"
#     click_on "Sign In"
#     expect(page).to have_content('Sign out')
#   end
#
#   scenario 'with invalid email' do
#     sign_up_with 'invalid_email', 'password'
#
#     visit root_path
#     expect(page).to have_content("Sign In")
#     click_on "sign in"
#     fill_in "Email", with: "nil"
#     fill_in "Password", with "1234"
#     click_on "Sign In"
#     expect(page).to have_content('Sign out')
#   end



  # scenario 'with invalid email' do
  #   sign_up_with 'invalid_email', 'password'
  #
  #   expect(page).to have_content('Sign in')
  # end
  #
  # scenario 'with blank password' do
  #   sign_up_with 'valid@example.com', ''
  #
  #   expect(page).to have_content('Sign in')

#
#   def sign_up_with(email, password)
#     visit sign_up_path
#     fill_in 'Email', with: email
#     fill_in 'Password', with: password
#     click_button 'Sign up'
#   end
# end

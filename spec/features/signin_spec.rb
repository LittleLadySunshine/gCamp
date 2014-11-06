require 'rails_helper'

feature "Users" do
  background do
    User.create(:email => 'user@example.com', :password => 'caplin')
  end

  scenario "Signing in with correct credentials" do
    visit '/sign-in'
    expect(page).to have_content("Sign In")
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'caplin'
    click_button 'Sign in'
  end
end

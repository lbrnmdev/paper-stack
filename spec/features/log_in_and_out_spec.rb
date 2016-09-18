require 'rails_helper.rb'

feature 'Log ins' do
  background do
    user = create(:user)
  end

  scenario 'user can log in' do
    visit '/'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content("Signed in successfully.")
  end

  scenario 'user can log out' do
    visit '/'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    click_link 'Logout'
    expect(page).to have_content("Signed out successfully.")
    # expect page to have log in link
    # expect attempt to visit account info to redirect to login page
  end
end

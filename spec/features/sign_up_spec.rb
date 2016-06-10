require 'rails_helper.rb'

feature 'Sign up' do
  scenario 'can sign up to be a user' do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
    # maybe not the right way to go about this??
    expect(User.first.email).to eq('user@example.com')
  end
end

require 'rails_helper.rb'

feature 'view account info' do
  background do
    user = create(:user_with_account)
    login_as(user, :scope => :user)
  end

  scenario 'user can view account info' do
    visit '/'
    click_link 'example account'
    expect(page).to have_content('Current balance')
    expect(page).to have_content('10.00')
  end
end

require 'rails_helper.rb'

feature 'edit account info' do
  background do
    user = create(:user_with_account)
    login_as(user, :scope => :user)
  end

  scenario 'user can edit account info' do
    visit '/'
    click_link 'example account'
    expect(page).to have_content('Current balance')
    expect(page).to have_content('10.00')
    click_link 'Edit account info'
    # fill_in 'Account Name', with: 'example edit'
    fill_in 'account_name', with: 'example edit'
    click_button 'Update Account'
    expect(page).to have_content('example edit')
  end
end

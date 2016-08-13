require 'rails_helper.rb'

feature 'delete account' do
  background do
    user = create(:user_with_account)
    login_as(user, :scope => :user)
  end

  scenario 'user can delete an account' do
    visit '/'
    click_link 'example account'
    expect(page).to have_content('Current balance')
    expect(page).to have_content('10.00')
    click_link 'Delete account'
    expect(page).to have_content('Account deleted successfully!')
    expect(page).to_not have_content('example account')
    expect(Account.find_by(:name => 'example account')).to be_nil
  end
end

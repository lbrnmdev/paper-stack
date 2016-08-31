require 'rails_helper.rb'

feature 'deposit amount in account' do
  background do
    user = create(:user_with_account)
    login_as(user, :scope => :user)
  end

  scenario 'with valid amount' do
    visit '/'
    click_link 'example account'
    click_button 'Deposit'
    fill_in 'deposit amount', with: 10.00
    click_button 'deposit!'
    expect(page).to have_content('€20.00')
    expect(Account.find_by(:name => 'example account').balance).to be == 20.00
  end
end

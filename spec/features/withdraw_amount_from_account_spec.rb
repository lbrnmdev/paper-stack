require 'rails_helper.rb'

feature 'withdraw amount from account' do
  background do
    user = create(:user_with_account)
    login_as(user, :scope => :user)
  end

  scenario 'with valid amount' do
    visit '/'
    click_link 'example account'
    click_button 'Withdraw'
    fill_in 'withdrawal amount', with: 10.00
    click_button 'withdraw!'
    expect(page).to have_content('€0.00')
    expect(Account.find_by(:name => 'example account').balance).to be == 0.00
  end
end

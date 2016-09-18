require 'rails_helper.rb'

feature 'delete transaktion' do
  background do
    user = create(:user_with_transaktion)
    login_as(user, :scope => :user)
  end

  scenario 'delete already existing' do
    visit '/'
    click_link 'example account'
    click_link 'deposit of five'
    # click_link 'Thu, 31 Oct 2002 00:02:02 UTC +00:00'
    expect(page).to have_content('Current balance is €15.00')
    expect(page).to have_content('Amount: €5.00')
    click_link 'Delete'
    expect(page).to have_content('Transaction deleted!')
    expect(page).to_not have_content('deposit of five')
    expect(page).to have_content('Current balance is €10.00')
  end
end

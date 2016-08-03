require 'rails_helper.rb'


feature 'bank account creations' do
  background do
    user = create(:user)
    login_as(user, :scope => :user)
  end

  scenario 'user can create a bank account' do
    visit '/'
    click_link 'Create Account'
    fill_in 'Account Name', with: 'example'
    # fill_in 'Starting Balance', with: '1000'
    click_button 'Create Account'
    expect(page).to have_content('example account created!')

    # expect index page to show created account information
    

    expect(Account.last.name).to eq('example')
    expect(Account.last.balance).to eq(0)
  end
end

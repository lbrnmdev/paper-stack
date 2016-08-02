require 'rails_helper.rb'


feature 'bank account creations' do
  background do
    user = create(:user)
    login_as(user, :scope => :user)
  end

  scenario 'user can create a bank account' do
    visit '/'
    click_link 'Create Account'
    fill_in 'Account Name', with: 'example account'
    fill_in 'Starting Balance', with: '1000'
    click_button 'Create Account'
    expect(page).to have_content('Account created successfully!')

    expect(User.account(id).name).to eq('example account')
    expect(User.account(id).balance).to eq(1000)
  end
end

require 'rails_helper'

feature 'Devise setting and root page', %(
  As a user,
  I want to be directed to user_profile page after login,
  so i can manage profile better.
) do
  scenario 'admin should be able to create a institution' do
    user = FactoryGirl.create(:user, :admin)
    user.confirm!
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'

    visit institutions_path
    expect(page).to have_content('add a new institution')
  end
end

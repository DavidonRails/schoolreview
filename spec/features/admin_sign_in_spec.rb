require 'rails_helper'

feature 'user login as admin', %(

  As a admin,
  I want to be able to login as an admin,
  So that i can do my duty.
) do
  scenario 'a non-admin user visit admin root' do
    user = FactoryGirl.create(:user)
    user.confirm!
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'

    visit admin_root_path

    expect(page).to have_content('You must be an admin to do that')
  end
end

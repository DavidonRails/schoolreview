require 'rails_helper'

RSpec.feature "signed in user can sign out", type: :feature do
  let!(:user) { FactoryGirl.create(:user) }

  before do
    user.confirm!
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
  end

  scenario do
    visit '/'
    click_link 'Sign Out'
    expect(page).to have_content "Signed out successfully."
  end
end

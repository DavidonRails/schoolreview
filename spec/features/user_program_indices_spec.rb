require 'rails_helper'

feature 'user needs a place to organize his programs', %{
  As a user
  I want to have a program page
  So that I can organize all of my programs
} do
  context 'user login' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      user.confirm!
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    scenario 'user should be able to
    click the organize programs button in profile page' do
      visit user_path user

      expect(page).to have_content('Organize programs')
    end

    scenario 'clicking the button will bring user to programs index page' do
      visit user_path user

      click_link "Organize programs"

      expect(page).to have_content('Program center')
    end
  end
end

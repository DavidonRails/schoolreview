require 'rails_helper'

feature 'user sets a profile picture', %{
  As a signed up user
  I want to be able to add a profile picture
  So that I can be amazing and popular
} do
  context 'login user' do
    let!(:user) { FactoryGirl.create(:user) }

    before do
      user.confirm!
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    scenario 'upload profile picture' do
      visit edit_user_path(user)
      attach_file('Profile photo', Rails.root + 'spec/fixtures/doge.png')
      click_button 'Accept Changes'

      expect(page).to have_xpath("//img")
    end
  end
end

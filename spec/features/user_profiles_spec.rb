require 'rails_helper'

feature 'user go to profile page', %{
  As a user
  I want to have a user profile page
  So that I can plan on my personal stuff
} do
  context 'user login' do
    scenario 'user should be able to see a skill set web component', js: true do
      # user = FactoryGirl.create(:user)
      # category = Category.create!(name: 'SQL', icons: 'something')
      # Skill.create!(name: 'Sample', description: 'thing', points: '2', user: user, category: category)
      # user.confirm!
      #
      # visit new_user_session_path
      # fill_in 'Email', with: user.email
      # fill_in 'user_password', with: user.password
      # click_button 'Log in'
      #
      # visit user_path user
      # expect(page).to have_content('My skill set')
    end
  end
end

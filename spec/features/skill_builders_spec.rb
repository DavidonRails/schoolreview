require 'rails_helper'

feature 'user should have a skill builder in profile page', %{
  As a user
  I want to have a skill builder in my page
  So that I can visually see my skills and have a
  better plan.
} do
  context 'user login' do
    let(:user) {FactoryGirl.create(:user)}

    before :each do
      user.confirm!
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    scenario 'user should be able to see a skill builder' do
      visit user_path user

      expect(page).to have_content('Add a skill')
      expect(page).to have_content('Add a program')
    end

    scenario 'user should be able to create a skill' do
      Category.create!(name: "SQL")
      visit user_path user

      click_link 'Add a skill'
      fill_in 'Name', with: 'Ruby'
      fill_in 'Description', with: 'Ruby is the best language!'
      select('1', from: 'Points')
      select 'SQL', from: "skill_category_id"
      click_button 'Add your skill'

      expect(page).to have_content('SQL')
    end

    scenario 'user should be able to create a program' do
      # visit user_path user
      # click_link 'Add a program'
      # select('Brown university', from: 'Choose an institution')
      # select('Biology & Medicine', from: 'Choose a program')
      # select('Brown university', from: 'Choose an institution')
      # select('Brown university', from: 'Choose an institution')
      # select('Brown university', from: 'Choose an institution')
    end

    scenario 'any program added should automatically mount the skills' do

    end
  end
end

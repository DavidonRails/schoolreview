require 'rails_helper'

feature 'institution features', %(
  As an admin user,
  I want to have the authority to create and destroy institutions,
  so i can manage my database better.
) do
  context 'login as an admin' do
    before(:each) do
      user = FactoryGirl.create(:user, :admin)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    scenario 'admin should be able to create a institution' do
      institution1 = FactoryGirl.create(:institution)
      institution2 = FactoryGirl.create(:institution)
      institution3 = FactoryGirl.create(:institution)

      visit institutions_path

      expect(page).to have_content(institution1.name)
      expect(page).to have_content(institution2.name)
      expect(page).to have_content(institution3.name)
    end

    scenario 'user should be able to see a specific institution' do
      institution = FactoryGirl.create(:institution)
      visit institution_path institution
      expect(page).to have_content(institution.name)
    end
  end
end

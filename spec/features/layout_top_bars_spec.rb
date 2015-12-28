require 'rails_helper'

feature 'topbar features', %(
  As a user
  I want my topbar to be a navigation section
  So i can navigat through this
) do
  context 'user logged-in in' do
    let(:user) { FactoryGirl.create(:user) }

    before (:each) do
      user.confirm!
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    scenario 'click institutions should take me to institution index page' do
      institution = FactoryGirl.create(:institution)

      click_link 'Institution'

      expect(page).to have_content(institution.name)
    end

    scenario 'click community should take me to users index page' do
      click_link 'Community'

      expect(page).to have_content(user.first_name)
    end
  end

  context 'a non-logged in user' do
    scenario 'should not be able to see edit and delete' do
      institution = FactoryGirl.create(:institution)
      program = FactoryGirl.create(:program, institution: institution)
      review = FactoryGirl.create(:review,
                                  institution: institution,
                                  program: program
                                  )

      visit institution_program_path(institution, program)

      expect(page).to_not have_content('edit')
      expect(page).to_not have_content('delete')
    end
  end
end

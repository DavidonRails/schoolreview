require 'rails_helper'

feature 'reviews edit and review', %(
  As a user
  I want to see all the reviews of a institution
  and the user who wrote them,
  so I can look for them for specific help
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

    scenario 'user should be able to see the review creation form' do
      institution = FactoryGirl.create(:institution)
      program = FactoryGirl.create(:program, institution: institution)

      visit institution_program_path(institution, program)
      click_link 'Add a review'

      expect(page).to have_content('Content')
      expect(page).to have_content('Title')
      expect(page).to have_content('Rating')
    end

    scenario 'user should be able to create a review' do
      institution = FactoryGirl.create(:institution)
      program = FactoryGirl.create(:program, institution: institution)

      visit institution_program_path(institution, program)
      click_link 'Add a review'

      fill_in 'Title', with: Faker::Lorem.sentence
      fill_in 'Content', with: Faker::Lorem.paragraph
      fill_in 'Rating', with: 8
      click_button 'Create Review'

      expect(page).to have_content(user.first_name)
      expect(page).to have_content("review successfully created!")
    end

    scenario 'when provided incorrect message, an error message will appear' do
      institution = FactoryGirl.create(:institution)
      program = FactoryGirl.create(:program, institution: institution)

      visit institution_program_path(institution, program)
      click_link 'Add a review'

      click_button 'Create Review'

      expect(page).to have_content("Title can\'t be blank")
    end

    scenario 'user should be able to edit its reviews' do
      institution = FactoryGirl.create(:institution)
      program = FactoryGirl.create(:program, institution: institution)
      review = FactoryGirl.create(:review,
                                  user: user,
                                  institution: institution,
                                  program: program
                                  )
      visit institution_program_path(institution, program)

      click_link 'edit'
      expect(page).to have_content('edit')
    end

    scenario 'user successfully edited its review' do
      institution = FactoryGirl.create(:institution)
      program = FactoryGirl.create(:program, institution: institution)
      review = FactoryGirl.create(:review,
                                  user: user,
                                  institution: institution,
                                  program: program
                                  )
      visit institution_program_path(institution, program)

      click_link 'edit'
      fill_in 'review[content]', with: 'This is greater'

      expect(page).to have_content('This is greater')
    end

    scenario 'user should not be able to
    see edit link of other user\'s review' do
      institution = FactoryGirl.create(:institution)
      program = FactoryGirl.create(:program, institution: institution)
      other_user = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review,
                                  user: other_user,
                                  institution: institution,
                                  program: program
                                  )

      visit institution_program_path(institution, program)

      expect(page).to_not have_content('edit')
    end
  end

  context 'a non-logged in user' do
    scenario 'should not be able to see edit and delete' do
      institution = FactoryGirl.create(:institution)
      program = FactoryGirl.create(:program, institution: institution)
      review = FactoryGirl.create(:review,
                                  institution: institution,
                                  program: program)

      visit institution_program_path(institution, program)

      expect(page).to_not have_content('edit')
      expect(page).to_not have_content('delete')
    end
  end
end

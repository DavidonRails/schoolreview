require 'rails_helper'

feature 'institution features', %(
  As a user
  I want to be able to view institution page,
  check details of the institution,
  see if there are any reviews of the institution,
  and have an idea of the star mentors in that institution.
) do

  scenario 'user should be able to see a list of institutions' do
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
    visit institution_path(institution)
    expect(page).to have_content(institution.name)
  end

  scenario 'click a institution title could see
    all the reviews under that institution' do
    institution1 = FactoryGirl.create(:institution)

    user = FactoryGirl.create(:user)
    program = FactoryGirl.create(:program, institution: institution1)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    visit institutions_path
    click_link institution1.name
    expect(page).to have_content(institution1.programs.first.title)
  end
end

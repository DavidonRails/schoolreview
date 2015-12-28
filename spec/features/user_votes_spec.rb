require 'rails_helper'

feature 'user can vote', %{
  As a signed in user,
  I want to be able to vote on reviews (up and down)
  So the best reviews are on top
} do

  scenario 'user sees buttons' do
    user = FactoryGirl.create(:user)
    user.confirm!
    institution = FactoryGirl.create(:institution)
    program = FactoryGirl.create(:program, institution: institution)
    FactoryGirl.create(:review, user: user,
                                         institution: institution,
                                         program: program)
    visit institution_program_path(institution, program)
    expect(page).to have_css(".fi-arrow-up")
    expect(page).to have_css(".fi-arrow-down")
  end
end

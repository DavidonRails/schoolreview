require 'rails_helper'

feature 'user login', %(

  As a review website,
  I want only my logged-in user can have access to certain features
  So that i can serve them better.

  Acceptance Criteria
  [ ] User must be able to log-in in index page
  [ ] User must be able to sign up
) do

  scenario 'user must be able to sign up in index page' do
    visit root_path
    click_link 'Sign Up'

    fill_in 'Email', with: "linghan@Me.com"
    fill_in 'user_password', with: "oasidjfiwjegf"
    fill_in 'user[first_name]', with: "Linghan"
    fill_in 'user[last_name]', with: "Xing"
    fill_in 'user[password_confirmation]', with: "oasidjfiwjegf"
    click_button 'Sign up'

    expect(page).to have_content("confirmation")
  end

  scenario 'required information is not supplied' do
    visit root_path
    click_link 'Sign Up'

    click_button 'Sign up'

    expect(page).to have_content("be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password confirmation does not match confirmation' do
    visit root_path
    click_link 'Sign Up'

    fill_in 'user_password', with: '12345'
    fill_in "user[password_confirmation]", with: "sidfjaef"

    click_button 'Sign up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end

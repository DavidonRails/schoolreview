require 'rails_helper'

feature 'user signs in', %{
  As a user
  I want to sign in
  So that I can track my breakable top progress
} do

  scenario 'an existing user specifies a valid email and password' do

    user = FactoryGirl.create(:user)
    user.confirm!
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    # fill_in 'Password Confirmation', with: user.password_confirmation
    click_button 'Log in'

    expect(page).to have_content("Welcome back!")
    expect(page).to have_content("Sign Out")
  end

  scenario 'an non-existant email and password is supplied' do
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: 'dsoifj@gmail.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'

    expect(page).to_not have_content('Welcome back!')
    expect(page).to_not have_content('Sign out')
    expect(page).to have_content('Invalid email or password')

  end

  scenario 'a existing email with the wrong password is denied access' do
    user = FactoryGirl.create(:user)
    user.confirm!
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'user_password', with: 'aefiwejf'
    click_button 'Log in'

    expect(page).to have_content('Invalid email or password')
    expect(page).to_not have_content('Sign out')

  end

  scenario 'an already authenticated user cannot re-sign in' do
    user = FactoryGirl.create(:user)
    user.confirm!

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')

    visit new_user_session_path
    expect(page).to have_content('You are already signed in')
  end
end

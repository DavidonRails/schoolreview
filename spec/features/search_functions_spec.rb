require 'rails_helper'

feature 'user should be able to search for an institution', %{
  As a user
  I want to be able to search for a specific institution
  So that I can find information quicker.
} do

  scenario 'user should be able to see a search box' do
    visit root_path

    expect(page).to have_button('Search')
  end

  scenario 'type in a keyword should find the relative institution' do
    institution = FactoryGirl.create(:institution)

    Institution.reindex
    Institution.searchkick_index.refresh

    visit root_path

    within(".collapse") do
      fill_in 'search', with: institution.name
      click_button 'Search'
    end

    expect(page).to have_content(institution.description)
  end
end

require 'rails_helper'

RSpec.feature "InstitutionShowPages", type: :feature do
  scenario 'a search box for programs should be available' do
    institution = FactoryGirl.create(:institution)
    visit institution_path institution

    expect(page).to have_button 'Search programs'
  end
end

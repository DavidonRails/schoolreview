require 'rails_helper'

RSpec.describe "webinars/show", type: :view do
  before(:each) do
    @webinar = assign(:webinar, Webinar.create!(
      :name => "Name",
      :filepath => "Filepath",
      :participates => 1,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Filepath/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
  end
end

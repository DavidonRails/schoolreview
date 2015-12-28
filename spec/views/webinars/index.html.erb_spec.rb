require 'rails_helper'

RSpec.describe "webinars/index", type: :view do
  before(:each) do
    assign(:webinars, [
      Webinar.create!(
        :name => "Name",
        :filepath => "Filepath",
        :participates => 1,
        :user => nil
      ),
      Webinar.create!(
        :name => "Name",
        :filepath => "Filepath",
        :participates => 1,
        :user => nil
      )
    ])
  end

  it "renders a list of webinars" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Filepath".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

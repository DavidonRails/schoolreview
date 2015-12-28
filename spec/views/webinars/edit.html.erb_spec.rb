require 'rails_helper'

RSpec.describe "webinars/edit", type: :view do
  before(:each) do
    @webinar = assign(:webinar, Webinar.create!(
      :name => "MyString",
      :filepath => "MyString",
      :participates => 1,
      :user => nil
    ))
  end

  it "renders the edit webinar form" do
    render

    assert_select "form[action=?][method=?]", webinar_path(@webinar), "post" do

      assert_select "input#webinar_name[name=?]", "webinar[name]"

      assert_select "input#webinar_filepath[name=?]", "webinar[filepath]"

      assert_select "input#webinar_participates[name=?]", "webinar[participates]"

      assert_select "input#webinar_user_id[name=?]", "webinar[user_id]"
    end
  end
end

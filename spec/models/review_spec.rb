require 'rails_helper'

describe Review do
  it { should validate_presence_of(:institution) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:program) }
  it { should validate_numericality_of(:rating) }

  it { should belong_to(:user) }
  it { should belong_to(:institution) }
  it { should belong_to(:program) }

  describe "#access_privilege" do
    let(:user) { FactoryGirl.create(:user, email: "user@loser.net") }

    it "returns true when user is logged in as the review owner" do
      review = FactoryGirl.create(
        :review,
        user: user
      )

      expect(review.access_privilege(user)).to eq(true)
    end

    it "returns true when user is logged in as admin" do
      review = FactoryGirl.create(
        :review,
        user: user
      )

      admin = FactoryGirl.create(:user, email: "im@theboss.net", admin: true)

      expect(review.access_privilege(admin)).to eq(true)
    end

    it "returns false if user is neither admin nor the route's user" do
      another_user = FactoryGirl.create(:user)

      review = FactoryGirl.create(:review,
        user: another_user
      )

      expect(review.access_privilege(user)).to eq(false)
    end
  end
end

require 'rails_helper'

describe Skill do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:points) }
  it { should validate_presence_of(:description) }

  it { should belong_to(:program) }
  it { should belong_to(:category) }
end

require 'rails_helper'

describe UserProgramAttendancy do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:program_id) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }

  it { should belong_to(:user) }
  it { should belong_to(:program) }
end

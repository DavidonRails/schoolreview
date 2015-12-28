class UserProgramAttendancy < ActiveRecord::Base
  belongs_to :user
  belongs_to :program

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :program_id, presence: true
  
end

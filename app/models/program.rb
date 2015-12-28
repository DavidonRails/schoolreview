class Program < ActiveRecord::Base
  belongs_to :institution
  has_many :reviews
  has_many :skills
  has_many :user_program_attendancies
  has_many :users, through: :user_program_attendancies

  validates :title, presence: true

  searchkick
end

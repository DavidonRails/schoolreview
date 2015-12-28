class Skill < ActiveRecord::Base
  belongs_to :program
  belongs_to :user
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :points, presence: true
end

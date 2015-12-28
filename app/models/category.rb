class Category < ActiveRecord::Base
  has_many :skills

  validates :name, presence: true
end

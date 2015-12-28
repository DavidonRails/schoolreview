class Institution < ActiveRecord::Base
  has_many :reviews
  has_many :programs

  validates :name, presence: true
  validates :state, presence: true
  validates :description, presence: true
  validates :city, presence: true
  validates :country, presence: true

  searchkick autocomplete: ['name']
end

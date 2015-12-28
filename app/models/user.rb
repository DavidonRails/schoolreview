class User < ActiveRecord::Base
  has_many :reviews
  has_many :skills
  has_many :user_program_attendancies
  has_many :programs, through: :user_program_attendancies
  has_many :webinars

  validates_presence_of :first_name
  validates_presence_of :last_name

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  mount_uploader :profile_photo, ProfilePhotoUploader

  def access_privilege(user)
    (user) && ((user.id == id) || (user.admin))
  end

  def check_admin(user)
    user.admin
  end

  def self.search(str)
    terms = str.split
    query = terms.map { |terms| "name like '%#{term}'" }.join( "OR" )
    User.where(query)
  end

end

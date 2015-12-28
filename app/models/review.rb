class Review < ActiveRecord::Base
  belongs_to :institution
  belongs_to :user
  belongs_to :program

  validates :institution, presence: true
  validates :title, presence: true
  validates :rating, presence: true
  validates :content, presence: true
  validates :program, presence: true
  validates :user, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 0..10, message: "The rating must be within 0 to 10!" }

  def access_privilege(user)
    (user) && ((user.id == user_id) || (user.admin))
  end

  acts_as_votable

  def score
    get_upvotes.size - get_downvotes.size
  end
end

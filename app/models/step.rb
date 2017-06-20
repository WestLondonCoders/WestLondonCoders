class Step < ActiveRecord::Base
  belongs_to :course
  has_many :comments, as: :commentable

  extend FriendlyId
  friendly_id :position, use: [:slugged, :finders]

  def author
    course.author
  end
end

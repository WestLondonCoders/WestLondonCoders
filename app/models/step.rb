class Step < ActiveRecord::Base
  belongs_to :course
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :step_completions, dependent: :destroy
  has_many :users, -> { distinct }, through: :step_completions

  extend FriendlyId
  friendly_id :position, use: [:slugged, :finders]

  validates_presence_of :position

  def author
    course.author
  end

  def completed_by?(user)
    step_completions.where(user: user).present?
  end

  def name
    "#{course.title}: #{title}"
  end
end

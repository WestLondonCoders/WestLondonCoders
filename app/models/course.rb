class Course < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :author, class_name: 'User'
  has_many :steps, -> { order(position: :asc) }, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :language_courses, dependent: :destroy
  has_many :languages, through: :language_courses
  has_many :users, -> { distinct }, through: :steps
  has_many :step_comments, through: :steps, source: :comments

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  scope :published, -> { where.not(published_at: nil) }

  def published?
    published_at.present?
  end

  def all_comments
    comments.count + step_comments.count
  end

  def path_to(comment)
    course_path(self, anchor: "comment-#{comment.id}")
  end

  def icon
    'fa-mortar-board'
  end

  def name
    title
  end
end

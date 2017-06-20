class Course < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :steps
  has_many :comments, as: :commentable
  has_many :language_courses
  has_many :languages, through: :language_courses
  has_many :users, -> { distinct }, through: :steps

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  scope :published, -> { where.not(published_at: nil) }

  def published?
    published_at.present?
  end
end

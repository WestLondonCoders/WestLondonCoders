class Course < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :steps
  has_many :comments, as: :commentable

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  scope :published, -> { where.not(published_at: nil) }

  def published?
    published_at.present?
  end
end

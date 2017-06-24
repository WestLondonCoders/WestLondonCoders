class Hackroom < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  has_many :user_hackrooms, dependent: :destroy
  has_many :users, through: :user_hackrooms
  has_many :hackroom_languages, dependent: :destroy
  has_many :languages, through: :hackroom_languages
  has_many :hackroom_primaries, dependent: :destroy
  has_many :primary_languages, through: :hackroom_primaries, source: :language
  has_many :hackroom_owners, dependent: :destroy
  has_many :owners, through: :hackroom_owners, source: :user
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :author, class_name: 'User'

  validates :name, presence: true, uniqueness: true

  scope :in_popularity_order, -> { order('popularity_score desc') }

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def all_members
    (owners.all + users.all).uniq
  end

  def colour
    primary_languages&.first&.colour || '#000000'
  end

  def title
    name
  end

  def path_to(comment)
    hackroom_path(self, anchor: "comment-#{comment.id}")
  end
end

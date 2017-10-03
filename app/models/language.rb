class Language < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  has_many :hackroom_languages, dependent: :destroy
  has_many :hackrooms, through: :hackroom_languages
  has_many :hackroom_primaries, dependent: :destroy
  has_many :primary_hackrooms, through: :hackroom_primaries, source: :hackroom
  has_many :user_languages, dependent: :destroy
  has_many :users, through: :user_languages
  has_many :user_primaries, dependent: :destroy
  has_many :primary_users, through: :user_primaries, source: :user
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :author, class_name: 'User'
  has_many :language_courses, dependent: :destroy
  has_many :courses, through: :language_courses

  scope :in_popularity_order, -> { order('popularity_score desc') }

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  mount_uploader :image, AvatarUploader

  def all_users
    (primary_users.all + users.all).uniq
  end

  def all_hackrooms
    (primary_hackrooms.all + hackrooms.all).uniq
  end

  def title
    name
  end

  def path_to(comment)
    language_path(self, anchor: "comment-#{comment.id}")
  end

  def icon
    'fa-keyboard-o'
  end
end

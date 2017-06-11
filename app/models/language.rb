class Language < ActiveRecord::Base
  has_many :hackroom_languages
  has_many :hackrooms, through: :hackroom_languages
  has_many :hackroom_primaries
  has_many :primary_hackrooms, through: :hackroom_primaries, source: :hackroom
  has_many :user_languages
  has_many :users, through: :user_languages
  has_many :user_primaries
  has_many :primary_users, through: :user_primaries, source: :user
  has_many :sponsor_languages
  has_many :sponsors, through: :sponsor_languages
  has_many :comments, as: :commentable

  scope :in_popularity_order, -> { order('popularity_score desc') }

  extend FriendlyId
  friendly_id :slug, use: :slugged

  def all_users
    (primary_users.all + users.all).uniq
  end
end

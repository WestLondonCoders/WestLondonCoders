class Hackroom < ActiveRecord::Base
  has_many :user_hackrooms
  has_many :users, through: :user_hackrooms

  has_many :hackroom_languages
  has_many :languages, through: :hackroom_languages

  has_many :hackroom_owners
  has_many :owners, through: :hackroom_owners, source: :user
end

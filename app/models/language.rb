class Language < ActiveRecord::Base
  has_many :hackroom_languages
  has_many :hackrooms, through: :hackroom_languages

  has_many :user_languages
  has_many :users, through: :user_languages
end

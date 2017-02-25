class UserLanguage < ActiveRecord::Base
  belongs_to :user
  belongs_to :language, dependent: :destroy
end

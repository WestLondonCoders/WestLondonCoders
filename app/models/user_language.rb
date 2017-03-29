class UserLanguage < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :language, dependent: :destroy
end

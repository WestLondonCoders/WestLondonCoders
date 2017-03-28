class SponsorLanguage < ActiveRecord::Base
  belongs_to :sponsor, dependent: :destroy
  belongs_to :language, dependent: :destroy
end

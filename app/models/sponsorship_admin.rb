class SponsorshipAdmin < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :user
end

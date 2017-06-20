class Step < ActiveRecord::Base
  belongs_to :course

  extend FriendlyId
  friendly_id :position, use: [:slugged, :finders]
end

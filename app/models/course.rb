class Course < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :steps

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
end

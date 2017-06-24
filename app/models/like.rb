class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  def icon
    'fa-thumbs-up'
  end
end

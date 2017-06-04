class CommentReply < ActiveRecord::Base
  belongs_to :comment
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  scope :published, -> { where(public: true) }
end

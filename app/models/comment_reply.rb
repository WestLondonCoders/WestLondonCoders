class CommentReply < ActiveRecord::Base
  act_as_mentioner
  belongs_to :author, class_name: 'User'
  belongs_to :comment

  validates :body, presence: true

  scope :published, -> { where(public: true) }
  scope :last_three, -> { order('created_at desc').limit(3).reverse }
  scope :in_created_by_order, -> { order('created_at asc') }
end

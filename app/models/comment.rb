class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true

  scope :published, -> { where(public: true) }
  scope :most_recent_first, -> { order("created_at desc") }
  scope :in_created_by_order, -> { order('created_at asc') }
  scope :from_posts, -> { where(commentable_type: 'Post') }
  scope :last_three, -> { order('created_at desc').limit(3).reverse }
  scope :top_level, -> { where.not(commentable_type: 'Comment') }

  def description
    "your comment"
  end

  def has_no_replies
    comments.published.empty?
  end

  def colour
    if defined?(commentable.colour)
      commentable.colour
    else
      author.colour
    end
  end

  def comment_path
    commentable.path_to(self)
  end

  def path_to(comment)
    commentable.comment_path(comment)
  end

  def icon
    'fa-comment-o'
  end

  def name
    'Reply'
  end
end

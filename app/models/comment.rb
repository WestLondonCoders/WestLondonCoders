class Comment < ActiveRecord::Base
  after_create :announce_comment

  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :replies, class_name: 'CommentReply'
  has_many :likes, as: :likeable

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

  private

  def announce_comment
    Slacked.post_async slack_message, channel: slack_channel, username: 'Comment Bot'
  end

  def slack_message
    comment_url = Rails.application.routes.url_helpers.post_path(commentable, anchor: "comment-#{id}")
    "#{author.name} commented: #{body} - #{link_host}#{comment_url}"
  end

  def slack_channel
    Rails.env.production? ? 'general' : 'testing'
  end

  def link_host
    "http://westlondoncoders.com"
  end
end

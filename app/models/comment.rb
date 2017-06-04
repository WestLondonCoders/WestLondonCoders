class Comment < ActiveRecord::Base
  after_create :announce_comment
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  belongs_to :author, class_name: 'User'
  has_many :replies, class_name: 'CommentReply'

  validates :body, presence: true

  scope :published, -> { where(public: true) }
  scope :most_recent_first, -> { order("created_at desc") }

  private

  def announce_comment
    Slacked.post_async slack_message, channel: slack_channel, username: 'Comment Bot'
  end

  def slack_message
    comment_url = Rails.application.routes.url_helpers.post_path(commentable, anchor: "comment-#{id}")
    "#{author.name} commented: #{body} - #{link_host}#{comment_url}"
  end

  def comment_url
    post_url(commentable, anchor: "comment-#{id}")
  end

  def slack_channel
    Rails.env.production? ? 'general' : 'testing'
  end

  def link_host
    "http://westlondoncoders.com" if Rails.env.production?
    "http://localhost:3000" if Rails.env.development?
  end
end

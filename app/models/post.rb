class Post < ActiveRecord::Base
  belongs_to :created_by, class_name: "User"
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :comments, as: :commentable, dependent: :destroy

  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :slug

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  def author
    created_by
  end
end

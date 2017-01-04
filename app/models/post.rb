class Post < ActiveRecord::Base
  belongs_to :created_by, class_name: "User"
  has_many :post_tags
  has_many :tags, through: :post_tags
  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :slug

  def to_param
    slug
  end
end

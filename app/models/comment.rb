class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  belongs_to :author, class_name: "User"
  validates :body, presence: true

  scope :published, -> do
    where(public: true)
  end
end

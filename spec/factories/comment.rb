FactoryGirl.define do
  factory :comment do
    body "I love Rails"
    public true
    author factory: :user
    commentable factory: :post
  end
end

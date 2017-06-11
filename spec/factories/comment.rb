FactoryGirl.define do
  factory :comment do
    body "I love Rails"
    public true
    author factory: :user
  end
end

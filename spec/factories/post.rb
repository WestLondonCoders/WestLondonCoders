FactoryGirl.define do
  sequence :slug do |n|
    "post-#{n}"
  end

  factory :post do
    slug { FactoryGirl.generate(:slug) }
    title "Why I love Rails"
    content "I love Rails because it's so cool"
    created_by factory: :user
  end
end

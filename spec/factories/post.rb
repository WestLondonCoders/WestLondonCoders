FactoryGirl.define do
  sequence :slug do |n|
    "post-#{n}"
  end

  factory :post do
    slug { FactoryGirl.generate(:slug) }
    title "Why I love Rails"
  end
end

FactoryGirl.define do
  factory :language do
    name 'Ruby'
    author factory: :user
  end
end

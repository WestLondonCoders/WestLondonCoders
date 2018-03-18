FactoryBot.define do
  factory :hackroom do
    name 'Rails room'
    mission 'We make cool apps'
    author factory: :user
  end
end

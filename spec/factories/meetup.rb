FactoryGirl.define do
  factory :meetup do
    name "Learn, discuss and practice code"
    description "This meetup will be cool"
    date 1.week.from_now
    finish_date 2.weeks.from_now
  end
end

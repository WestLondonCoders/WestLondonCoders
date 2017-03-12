FactoryGirl.define do
  factory :sponsor do
    name "Net-a-porter"
    description "This sponsor has nice offices"
    link "nap.com"
    logo { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'example-sponsor-logo.jpg')) }
    listed true
  end
end

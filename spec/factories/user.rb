FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "Jake #{n}"
    end

    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'example-image.jpg')) }
  end
end

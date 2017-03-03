FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "Jake #{n}"
    end

    email 'jake.shears@scissorsisters.com'
    password 'wtf123'
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'example-image.jpg')) }
    bio 'I make cool songs'
  end
end

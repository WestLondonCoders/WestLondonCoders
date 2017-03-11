FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "Jake #{n}"
    end

    sequence :email do |n|
      "jake.shears#{n}@scissorsisters.com"
    end

    password 'wtf123'
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'example-image.jpg')) }
    bio 'I make cool songs'
  end

  factory :admin, parent: :user do
    roles { [FactoryGirl.create(:role, name: 'Admin')] }
  end

  factory :sponsorship_admin, parent: :user do
    roles { [FactoryGirl.create(:role, name: 'sponsor')] }
    sponsors { [FactoryGirl.create(:sponsor, name: 'Sky')] }
  end
end

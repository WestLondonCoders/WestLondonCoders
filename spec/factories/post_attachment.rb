FactoryGirl.define do
  factory :post_attachment do
    avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'example-image.jpg')) }
    post_id 12
  end
end

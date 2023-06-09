FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6) }
    profile { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'test_image.png'), 'image/png') }
  end
end

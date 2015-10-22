FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    sequence :email do |n|
      "person#{n}@example.com"
    end

    password '12345678'
    password_confirmation '12345678'

    trait :invalid do
      email nil
    end

    trait :avatar do
      avatar do
        Rack::Test::UploadedFile.new(
          File.join(Rails.root, 'spec', 'support', 'images', 'avatar.png')
        )
      end
    end
  end
end

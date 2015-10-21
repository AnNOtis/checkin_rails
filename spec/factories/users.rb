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
  end
end

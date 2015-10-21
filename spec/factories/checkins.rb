FactoryGirl.define do
  factory :checkin do
    name { Faker::Name.name }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end

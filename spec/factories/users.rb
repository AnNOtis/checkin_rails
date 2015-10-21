FactoryGirl.define do
  factory :user do
    name 'LETMEIN'
    email 'letmein@gmail.com'
    password '12345678'
    password_confirmation '12345678'
  end

  trait :invalid do
    email nil
  end
end

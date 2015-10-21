FactoryGirl.define do
  factory :device do
    user
    user_agent "ANDROID XXX"
    device_token { SecureRandom.hex(5) }
  end
end

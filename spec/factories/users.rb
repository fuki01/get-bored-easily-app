FactoryBot.define do
  factory :user do
    username { "Tester" }
    sequence(:email) { |n| "Tester#{n}@example.com" }
    password { "tester-password-test" }
  end
end

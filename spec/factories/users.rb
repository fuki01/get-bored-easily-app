FactoryBot.define do
  factory :user, class: User do
    username {"TestUser"}
    sequence(:email) { |n| "TestEmail#{n}@example.com"}
    password {"tester-password-test"}
  end
end

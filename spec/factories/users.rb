FactoryBot.define do
  factory :user, class: User do
    username {"TestUser"}
    email {"TestEmail@example.com"}
    password {"tester-password-test"}
  end
  factory :another_user, class: User do
    username { "Tester" }
    email { "Testerss#@example.com" }
    password { "tester-password-test" }
  end
end

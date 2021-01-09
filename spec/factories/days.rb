FactoryBot.define do
  factory :day do
    entryday { (Time.now - 1.days).strftime('%Y%m%d') }
    association :target
    association :user
    
    trait :today do
      entryday { Time.now.strftime('%Y%m%d') }
    end
  end
end

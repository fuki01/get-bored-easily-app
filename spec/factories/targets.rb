FactoryBot.define do
  factory :target do 
    sequence(:body) { |n|"早く寝る#{n}"}
    association :user
  end
end

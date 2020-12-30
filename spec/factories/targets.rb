FactoryBot.define do
  factory :target do 
    body {'早く寝る'}
    association :user
  end
end

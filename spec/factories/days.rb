FactoryBot.define do
  TimeToday = Time.now - 1.days
  factory :day, class: Day do
    count { 1 }
    entryday { TimeToday.strftime('%Y%m%d') }
  end
  factory :another_day, class: Day do
    count { 1 }
    entryday { Time.now.strftime('%Y%m%d') }
  end
end

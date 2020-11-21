FactoryBot.define do
  factory :target, class: Target do
    body { "早く寝る"}
    clear { false }
  end
  factory :target_clear, class: Target do
    body {"テスト用データ"}
    clear { true }
  end
end

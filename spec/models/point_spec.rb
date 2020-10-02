require 'rails_helper'

RSpec.describe Point, type: :model do
  context '無効' do
    it "sumが無ければ無効な状態であること" do
      point = Point.new(
        sum: nil
      )
      point.valid?
      expect(point.errors[:sum]).to include("が入力されていません。")
    end
    it "target_idが無ければ無効な状態であること" do
    end
  end
  context '有効' do
    it "sum target_idが有効な状態であること" do
    end
  end
end

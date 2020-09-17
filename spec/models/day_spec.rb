require 'rails_helper'

RSpec.describe Day, type: :model do
  context '無効'do
    it "possibleが無ければ無効" do
      day = Day.new(
        possible: nil
      )
      day.valid?
      expect(day.errors[:possible]).to include("が入力されていません。")
    end
    it "countが無ければ無効" do
      day = Day.new(
        count: nil
      )
      day.valid?
      expect(day.errors[:count]).to include("が入力されていません。")
    end
    it "target_idが無ければ無効" do
      day = Day.new(
        target_id: nil
      )
      day.valid?
      expect(day.errors[:target_id]).to include("が入力されていません。")
    end
    it "entrydayが無ければ無効" do
      day = Day.new(
        entryday: nil
      )
      day.valid?
      expect(day.errors[:target_id]).to include("が入力されていません。")
    end
  end
end

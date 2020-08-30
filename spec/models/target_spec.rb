require 'rails_helper'

RSpec.describe Target, type: :model do
  context '無効' do
    it "bodyが無ければ無効な状態である事" do
      target = Target.new(
        body: nil
      )
      target.valid?
      expect(target.errors[:body]).to include("が入力されていません。")
    end
    it "user_idが無ければ無効な状態である事" do
      target = Target.new(
        user_id: nil
      )
      target.valid?
      expect(target.errors[:user_id]).to include("が入力されていません。")
    end
  end
  context '有効' do
    it "user_idとbody有れば有効な状態である事" do
      expect(FactoryBot.build(:target, user: FactoryBot.create(:user))).to be_valid
    end
  end
end

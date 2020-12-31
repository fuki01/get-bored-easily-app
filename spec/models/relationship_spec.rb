require 'rails_helper'

RSpec.describe Relationship, type: :model do
  context '無効' do
    it "user_idが無ければ無効な状態であること" do
      relation = Relationship.new(
        user_id: nil
      )
      relation.valid?
      expect(relation.errors[:user_id]).to include("が入力されていません。")
    end
    it "follow_idが無ければ無効な状態であること" do
      relation = Relationship.new(
        follow_id: nil
      )
      relation.valid?
      expect(relation.errors[:follow_id]).to include("が入力されていません。")
    end
  end
  context '有効' do
    it "user_id,follow_idがあれば有効であること" do
      user = FactoryBot.create(:user)
      another_user = FactoryBot.create(:user)
      relation = Relationship.new(
        follow_id: user.id,
        user_id: another_user.id
      )
      expect(relation).to be_valid
    end
  end
end

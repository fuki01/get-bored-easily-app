require 'rails_helper'

RSpec.describe User, type: :model do
  it "ユーザ名、メールアドレス、パスワードがあれば有効であること" do
    user = User.new(
      username: "Testuser",
      email: "Test@example.com",
      password: "TestuserPassword"
    )
    expect(user).to be_valid
  end

  it "usernameが無ければ無効な状態であること" do
    user = User.new(
      username: nil
    )
    user.valid?
    expect(user.errors[:username]).to include("が入力されていません。")
  end

  it "emailが無ければ無効な状態であること" do
    user = User.new(
      email: nil
    )
    user.valid?
    expect(user.errors[:email]).to include("が入力されていません。")
  end

  it "重複したemailなら無効な状態であること" do
    User.create(
      username: "Testuser",
      email: "Test@example.com",
      password: "TestuserPassword"
    )
    user = User.new(
      username: "Testuser",
      email: "Test@example.com",
      password: "TestuserPassword"
    )
    user.valid?
    expect(user.errors[:email]).to include("は既に使用されています。")
  end
 end

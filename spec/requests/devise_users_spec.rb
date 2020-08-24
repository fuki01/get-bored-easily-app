require 'rails_helper'

RSpec.describe "DeviseUsers", type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user)}
  let(:invalid_user_params) { attributes_for(:user, username: "") }

  describe "POST #create" do
    before do
    end
    context 'パラメータが妥当な場合' do
      it "リクエストが成功する事" do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
      end
      it "createが成功する事" do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end
      it "リダイレクトされる事" do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_url
      end
    end

    context 'パラメータが不当な場合' do
      it "リクエストが成功する事" do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end
      it "createが失敗する事" do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.to_not change(User, :count)
      end
      it "エラーが表される事" do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include 'Username が入力されていません。'
      end
    end
  end
end

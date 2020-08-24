require 'rails_helper'

RSpec.describe "UsersAutentications", type: :request do
  let(:user) { create(:user) }

  describe 'GET #edit' do
    subject{ get edit_user_registration_path }

    context 'ログインしている場合' do
      before do
        sign_in user
      end
      
      it "リクエストが成功する事" do
        is_expected.to eq 200
      end
    end

    context 'ログインしていない場合' do
      it "リダイレクトされる事" do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end
end

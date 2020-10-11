# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TargetController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:another_user) { FactoryBot.build(:another_user) }
  describe 'GET #show' do
    it 'アクセスが成功する事' do
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
    it '200レスポンスが返ってくる事' do
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to have_http_status '200'
    end
  end

  describe 'GET #new' do
    it 'アクセスが成功する事' do
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
    it '200レスポンスが返ってくる事' do
      sign_in user
      get :new
      expect(response).to have_http_status '200'
    end
  end

  describe 'POST #create' do
    let(:target_attributes) { attributes_for(:target) }
    context 'パラメータが妥当な場合' do
      it '302レスポンスが返ってくる事' do
        sign_in user
        post :create, params: {
          target: target_attributes
        }
        expect(response).to have_http_status '302'
      end
      it '正確に目標を作成できる事' do
        sign_in user
        expect  do
          post :create, params: {
            target: target_attributes
          }
        end.to change(Target, :count).by(1)
      end
      it 'リダイレクトが正しい事' do
        sign_in user
        post :create, params: {
          target: target_attributes
        }
        expect(response).to redirect_to target_path(user.id)
      end
    end
    context 'パラメータが不正な場合' do
      it 'リダイレクトが正しいこと' do
        sign_in user
        post :create, params: {
          target: {
            body: nil,
            user_id: user.id
          }
        }
        expect(response).to redirect_to target_path(user.id)
      end
      it 'ユーザーが登録されないこと' do
        sign_in user
        expect do
          post :create, params: {
            target: {
              body: nil,
              user_id: user.id
            }
          }
        end.to_not change(Target, :count)
      end
    end
    context 'ログインしていない場合' do
      it '302レスポンスが返ってくる事' do
        post :create
        expect(response).to have_http_status '302'
      end
      it 'リダイレクトが正しいこと' do
        post :create
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインしている場合' do
      it '正常なレスポンスの場合' do
        sign_in user
        get :edit, params: { id: user.id }
        expect(response).to be_successful
      end
      it '200レスポンスが返ってくる事' do
        sign_in user
        get :edit, params: { id: user.id }
        expect(response).to have_http_status '200'
      end
    end
    context '無許可なユーザーな場合' do
      it '正常なレスポンスが返ってくる事' do
        sign_in another_user
        get :edit, params: { id: user.id }
        expect(response).to_not be_successful
      end
    end
    context 'ログインしていない場合' do
      it '302レスポンスが返ってくる事' do
        post :edit, params: { id: user.id }
        expect(response).to have_http_status '302'
      end
      it 'リダイレクトが正しいこと' do
        post :edit, params: { id: user.id }
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'ログインしている場合' do
      before do
        @target = FactoryBot.build(:target)
        @target.user_id = user.id
        @target.save
      end
      it '正常に目標を変更できる事' do
        sign_in user
        target_params = { body: '朝起きる' }
        patch :update, params: { id: user.id, target: target_params }
        expect(user.targets.last.reload.body).to eq '朝起きる'
      end
      it 'リダイレクトが正しい事' do
        sign_in user
        target_params = { body: '朝起きる' }
        patch :update, params: { id: user.id, target: target_params }
        expect(response).to redirect_to target_path(user.id)
      end
    end
    context 'パラメータが不正な場合' do
      before do
        @target = FactoryBot.build(:target)
        @target.user_id = user.id
        @target.save
      end
      it '記事を更新しない事' do
        sign_in user
        target_params = { body: nil }
        patch :update, params: { id: user.id, target: target_params }
        expect(user.targets.last.reload.body).to eq "早く寝る"
      end
      it 'リダイレクトが正しい事' do
        sign_in user
        target_params = { body: nil }
        patch :update, params: { id: user.id, target: target_params }
        expect(response).to redirect_to edit_target_path(user.id)
      end
    end
    context 'ログインしていない場合' do
      before do
        @target = FactoryBot.build(:target)
        @target.user_id = user.id
        @target.save
      end
      it '正常なレスポンスが返ってくる事' do
        target_params = {
          body: "朝起きる",
          user_id: 1
        }
        patch :update, params: { id: @target.id, target: target_params }
        expect(response).to have_http_status '302'
      end
      it 'リダイレクトが正しい事' do
        target_params = {
          body: "朝起きる",
          user_id: 1
        }
        patch :update, params: { id: @target.id, target: target_params }
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe '#DELETE #delete' do
    context 'ログインしている場合' do
      before do
        @target = FactoryBot.build(:target)
        @target.user_id = user.id
        @target.save
      end
      it '正常に目標を消去できる場合' do
        sign_in user
        expect {
          delete :destroy, params: {id: user.id}
        }.to change(Target, :count).by(-1)
      end
      it 'リダイレクトが正しい事' do
        sign_in user
        delete :destroy, params: {id: user.id}
        expect(response).to redirect_to target_path(user.id)
      end
    end
    context 'ログインしていない場合' do
      it '302レスポンスを返す事' do
        delete :destroy, params: {id: user.id}
        expect(response).to have_http_status "302"
      end
      it 'リダイレクトが正しい事' do
        delete :destroy, params: {id: user.id}
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe '#GET #list' do
    context 'ログインしている場合'do
      it 'アクセスが成功する事' do
        sign_in user
        get :list
        expect(response).to be_successful
      end
    end
    context 'ログインしていない場合'do
      it 'アクセスが成功しないこと' do
        get :list
        expect(response).to_not be_successful
      end
    end
  end
end

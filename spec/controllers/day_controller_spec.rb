# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DayController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @target = FactoryBot.create(:target, user: @user)
    @day = FactoryBot.create(:day, count: 1,entryday: (Time.now - 1.days).strftime('%Y%m%d'), target_id: @target.id, user_id: @user.id)
  end
  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      day_params = FactoryBot.attributes_for(:day)
      it '302レスポンスが返ってくる事' do
        sign_in @user
        post :create, params: {
          target_id: @target.id,
          day: day_params
        }
        expect(response).to have_http_status '302'
      end
      it '正確にDayを作成できる事' do
        sign_in @user
        expect do
          post :create, params: {
          target_id: @target.id,
            day: day_params
          }
        end.to change(Day, :count).by(1)
      end
      it 'リダイレクトが正しい事' do
        sign_in @user
        post :create, params: {
          target_id: @target.id,
          day: day_params
        }
        expect(response).to redirect_to target_index_path
      end
      it '作成日が連日で有ればcountが加算されること' do
        @day = FactoryBot.create(:day, count: 1,entryday: (Time.now - 1.days).strftime('%Y%m%d'), target_id: @target.id, user_id: @user.id)
        sign_in @user
        post :create, params: {
          target_id: @target.id
        }
        expect(@user.targets.find(@target.id).day.last.count).to eq 2
      end

      it 'countが７になった場合のリダイレクトが正しいこと' do
        @day = FactoryBot.create(:day, count: 6,entryday: (Time.now - 1.days).strftime('%Y%m%d'), target_id: @target.id, user_id: @user.id)
        sign_in @user
        post :create, params:{
          target_id: @target.id
        }
        expect(response).to redirect_to target_clear_path
      end
    end
    context 'パラメータが不当な場合' do
      it '作成日が連日で無ければcountがされないこと' do
        @day = FactoryBot.create(:day, count: 6,entryday: (Time.now - 2.days).strftime('%Y%m%d'), target_id: @target.id, user_id: @user.id)
        sign_in @user
        post :create, params: {
          target_id: @target.id
        }
        expect(@user.targets.last.day.last.count).to eq 1
      end
      it 'countが７でない場合のリダイレクトが正しいこと' do
        @day = FactoryBot.create(:day, count: 1,entryday: (Time.now - 1.days).strftime('%Y%m%d'), target_id: @target.id, user_id: @user.id)
        sign_in @user
        post :create, params: {
          target_id: @target.id
        }
        expect(response).to redirect_to target_index_path
      end
    end
  end
  context 'ログインしていない場合' do
    it "302レスポンスが返ってくること" do
      post :create, params:{target_id: @target.id}
      expect(response).to have_http_status '302'
    end
    it "リダイレクトが正しいこと" do
      post :create, params:{target_id: @target.id}
      expect(response).to redirect_to user_session_path
    end
  end
  describe 'DELETE #destroy' do
    context 'ログインしている場合' do
      it '正常にDayを消去できる事' do
        sign_in @user
        expect{
          delete :destroy, params: { id: @day.id ,target_id: @target.id }
        }.to change(Day, :count).by(-1)
      end
      it 'リダイレクトが正しい事' do
        sign_in @user
        delete :destroy, params: { id: @day.id ,target_id: @target.id }
        expect(response).to redirect_to target_path(@day.id)
      end
    end
    context 'ログインしていない場合' do
      it '302レスポンスを返す場合' do
        delete :destroy, params: { id: @day.id ,target_id: @target.id }
        expect(response).to have_http_status "302"
      end
      it 'リダイレクトが正しい場合' do
        delete :destroy, params: { id: @day.id ,target_id: @target.id }
        expect(response).to redirect_to user_session_path
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DayController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @target = FactoryBot.build(:target)
    @target.user_id = @user.id
    @target.save
  end
  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      day_params = FactoryBot.attributes_for(:day)
      it '302レスポンスが返ってくる事' do
        day_params = FactoryBot.attributes_for(:day)
        sign_in @user
        post :create, params: {
          day: day_params
        }
        expect(response).to have_http_status '302'
      end
      it '正確にDayを作成できる事' do
        sign_in @user
        expect do
          post :create, params: {
            day: day_params
          }
        end.to change(Day, :count).by(1)
      end
      it 'リダイレクトが正しい事' do
        sign_in @user
        post :create, params: {
          day: day_params
        }
        expect(response).to redirect_to target_path(@user.id)
      end
      it '作成日が連日で有ればcountが加算されること' do
        @day = FactoryBot.build(:day)
        @day.target_id = @target.id
        @day.save
        sign_in @user
        post :create, params: {
          target_id: @target.id
        }
        expect(@user.target.day.last.count).to eq 2
      end
      it '作成日が連日で無ければcountがされないこと' do
        @another_day = FactoryBot.build(:another_day)
        @another_day.target_id = @target.id
        @another_day.save
        sign_in @user
        post :create, params: {
          target_id: @target.id
        }
        expect(@user.target.day.last.count).to eq 1
      end
    end
  end
  context 'ログインしていない場合' do
    it "302レスポンスが返ってくること" do
      post :create
      expect(response).to have_http_status '302'
    end

    it "リダイレクトが正しいこと" do
      post :create
      expect(response).to redirect_to user_session_path
    end
  end
  describe 'DELETE #destroy' do
    before do
      @day = FactoryBot.build(:day)
      @day.target_id = @target.id
      @day.save
    end
    context 'ログインしている場合' do
      it '正常にDayを消去できる事' do
        sign_in @user
        expect{
          delete :destroy, params: { id: @target.id }
        }.to change(Day, :count).by(-1)
      end
      it 'リダイレクトが正しい事' do
        sign_in @user
        delete :destroy, params: { id: @target.id }
        expect(response).to redirect_to target_path(@user.id)
      end
    end
    context 'ログインしていない場合' do
      it '302レスポンスを返す場合' do
        delete :destroy, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end
      it 'リダイレクトが正しい場合' do
        delete :destroy, params: { id: @user.id }
        expect(response).to redirect_to user_session_path
      end
    end
  end
end

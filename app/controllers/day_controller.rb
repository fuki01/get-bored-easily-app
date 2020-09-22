class DayController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.find(current_user.id)
    if !( @user.target.day.first.nil? )
      @previous_day = @user.target.day.last
      @previous_day_cunt = @user.target.day.last.count
    end
    if !(@user.target.day.last.nil?)
      @day = @user.target.day.build
      @day.entryday =  Time.now.strftime('%Y%m%d')
      if (Time.now.strftime('%Y%m%d').to_i - @previous_day.entryday.strftime("%Y%m%d").to_i) == 1
        @day.count = @previous_day_cunt+1
      else
        @day.count = 1
      end
    else
      @day = @user.target.day.build(day_params)
      @day.entryday =  Time.now.strftime('%Y%m%d')
      @day.count = 1
    end
    if @day.save
      redirect_to "/target/#{current_user.id}", notice: '登録できました。'
    else
      redirect_to "/target/#{current_user.id}", notice: '登録できませんでした。'
    end
  end

  def destroy
    @user = User.find(current_user.id)
    if @user.target.day.last.destroy
      redirect_to "/target/#{current_user.id}", notice: '消去できました。'
    else
      redirect_to "/target/#{current_user.id}", notice: '消去できませんでした。'
    end
  end
  private
  def day_params
    params.permit(:possible)
  end
end

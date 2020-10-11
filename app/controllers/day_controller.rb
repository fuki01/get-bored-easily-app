class DayController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.find(current_user.id)
    if !( @user.target.day.first.nil? )
      @previous_day = @user.target.day.last
      @previous_day_cunt = @user.target.day.last.count
    end
    if !(set_day.last.nil?)
      @day = @user.target.day.build
      @day.entryday =  time_now_format
      if (Time.now.strftime('%Y%m%d').to_i - @previous_day.entryday.strftime("%Y%m%d").to_i) == 1
        @day.count = @previous_day_cunt+1
      else
        @day.count = 1
      end
    else
      @day = @user.target.day.build
      @day.entryday = time_now_format
      @day.count = 1
    end
    @point_sum = @day.count * 100
    set_point.create(sum: @point_sum)
    if @day.save
      text = "本日は、#{@day.count*100}ポイント取得しました。".html_safe
      redirect_to "/target/#{current_user.id}"
      flash[:notice]= text
    else
      redirect_to "/target/#{current_user.id}", notice: '登録できませんでした。もう一度お試しください。'

    end
  end

  def destroy
    @user = User.find(current_user.id)
    set_point.last.destroy
    if set_day_last.destroy
      redirect_to "/target/#{current_user.id}", notice: '消去できました。'
    else
      redirect_to "/target/#{current_user.id}", notice: '消去できませんでした。'
    end
  end

  private
  def set_day
    @user.target.day
  end

  def set_day_last
    @user.target.day.last
  end

  def day_params
    params.require(:day).permit(:possible)
  end
  def set_point
    @user.target.point
  end
  def time_now_format
    Time.now.strftime('%Y%m%d')
  end
end

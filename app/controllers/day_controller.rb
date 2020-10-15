class DayController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = user_find
    if !( set_day.first.nil? )
      @previous_day = set_day_last
      @previous_day_cunt = set_day_last.count
    end
    if !(set_day_last.nil?)
      @day = set_day.build
      @day.entryday =  time_now_format
      if (Time.now.strftime('%Y%m%d').to_i - @previous_day.entryday.strftime("%Y%m%d").to_i) == 1
        @day.count = @previous_day_cunt+1
      else
        @day.count = 1
      end
    else
      @day = set_day.build
      @day.entryday = time_now_format
      @day.count = 1
    end
    @point_sum = @day.count * 100
    set_point.create(sum: @point_sum)
    if @day.save && @day.count == 7
      text = "7日連続で達成されました！".html_safe
      redirect_to target_clear_path(@user.targets.last.id)
      flash[:notice]= text
    elsif @day.save
      text = "本日は、#{@day.count*100}ポイント取得しました。".html_safe
      redirect_to target_path(current_user.id)
      flash[:notice]= text
    else
      
      redirect_to target_path(current_user.id), notice: '登録できませんでした。もう一度お試しください。'
    end
  end

  def destroy
    @user = user_find
    set_point.last.destroy
    if set_day_last.destroy
      redirect_to target_path(current_user.id), notice: '消去できました。'
    else
      redirect_to target_path(current_user.id), notice: '消去できませんでした。'
    end
  end

  private


  def day_build
    set_day.build
  end

  def set_day
    @user.targets.last.day
  end

  def set_day_last
    @user.targets.last.day.last
  end

  def day_params
    params.require(:day).permit(:possible)
  end
  def set_point
    @user.targets.last.point
  end
  def time_now_format
    Time.now.strftime('%Y%m%d')
  end
  def user_find
    User.find(current_user.id)
  end
end

class DayController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = user_find
    if not_day_first_nil?
      @previous_day_cunt = set_day_last.count
    end
    if !(set_day_last.nil?)
      @day = set_day.build
      @day.entryday =  time_now_format
      if day_continuous == 1 
        @day.count = @previous_day_cunt+1
      else
        add_a_count
      end
    else
      @day = set_day.build
      @day.entryday = time_now_format
      add_a_count
    end
    @point_sum = @day.count*100
    set_point.create(sum: @point_sum,User_id: @user.id)
    if @day.count >7
      redirect_to new_target_path, notice: '登録できませんでした。'
    elsif @day.save && @day.count == 7
      @user.targets.last.update(clear: true);
      text = "7日連続で達成されました！".html_safe
      flash[:notice]= text
      redirect_to target_clear_path
    elsif @day.save && @day.count <= 7
      text = "本日は、100ポイント取得しました。".html_safe
      redirect_to target_index_path
      flash[:notice]= text
    end
  end

  def destroy
    @user = user_find
    if @user.targets.last.day.last.destroy && @user.targets.last.point.last.destroy
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

  def add_a_count
    @day.count = 1
  end
end

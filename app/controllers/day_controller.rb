class DayController < ApplicationController
  def create
    @user = User.find(current_user.id)
    if !( @user.target.day.first.nil? )
      @previous_day = @user.target.day.last
      @previous_day_cunt = @user.target.day.last.count
    end
    if !(@user.target.day.last.nil?)
      @day = @user.target.day.build(day_params)
      if (Time.now.strftime('%Y%m%d').to_i - @previous_day.created_at.strftime('%Y%m%d').to_i) == 1
        @day.count = @previous_day_cunt+1
      else
        @day.count = 1
      end
    else
      @day = @user.target.day.build(day_params)
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
    params.require(:day).permit(:possible)
  end
end

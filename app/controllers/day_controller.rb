# frozen_string_literal: true

class DayController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.find(current_user.id)
    @day = set_day.build
    @day.entryday =Time.now.strftime('%Y%m%d')
    if !set_day_last.nil?
      @previous_day = set_day_last
      @previous_day_cunt = set_day_last.count
      if (Time.now.strftime('%Y%m%d').to_i - @previous_day.entryday.strftime("%Y%m%d").to_i) == 1
        day_count = @previous_day_cunt + 1
      else
        @day.count = 1
      end
    else
      @day.count = 1
    end
    @point_sum = @day.count * 100
    set_point.create(sum: @point_sum)
    if @day.save
      redirect_to "/target/#{current_user.id}", notice: '登録できました。'
    else
      redirect_to "/target/#{current_user.id}", notice: '登録できませんでした。'
    end
  end

  def destroy
    @user = User.find(current_user.id)
    if set_day_last.destroy && set_point.last.destroy
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

  def set_point
    @user.target.point
  end
end

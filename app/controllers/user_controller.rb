class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @point = Point.where(user_id: @user.id).sum(:sum)
  end
end
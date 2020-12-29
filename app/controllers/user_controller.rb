class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :access_restriction!,{only:[:show]}

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @point = Point.where(user_id: @user.id).sum(:sum)
    @follow_cnt = Relationship.where(user_id: current_user.id).count;
    @follower_cnt = Relationship.where(follow_id: current_user.id).count;
  end
end
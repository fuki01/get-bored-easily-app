class UserController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @point = @user.user_point(@user)
    @follow_cnt = Relationship.where(user_id: params[:id]).count;
    @follower_cnt = Relationship.where(follow_id: params[:id]).count;
  end
end
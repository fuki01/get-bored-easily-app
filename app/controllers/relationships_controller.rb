class RelationshipsController < ApplicationController
  before_action :set_user,only: [:destroy,:create]

  
  def follow
    @follows = Relationship.where(follow_id: params[:id]);
  end
  def follower
    @followers = Relationship.where(user_id: params[:id]);
  end
  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to user_list_path
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to user_list_path
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to user_list_path
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to user_list_path
    end
  end

  private
  def set_user
    @user = User.find params[:follow_id]
  end
end

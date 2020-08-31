class TargetController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @user = User.find(params[:id])
    @target = @user.target
  end

  def new
    @user = User.new
    @target = Target.new
  end

  def create
    @user = User.find(current_user.id)
    @target = @user.build_target(target_params)
    if @target.save
      redirect_to "/target/#{current_user.id}", notice: '目標を設定しました。'
    else
      redirect_to "/target/#{current_user.id}", notice: '目標を設定できませんでした。'
    end
  end

  def destroy
    @user = User.find(current_user.id)
    if @user.target.destroy
      redirect_to target_path, notice: '目標を削除しました。'
    else
      redirect_to target_path, notice: '目標を削除できませんでした。'
    end
  end

  def edit
  end

  private

  def target_params
    params.require(:target).permit(:body)
  end
end

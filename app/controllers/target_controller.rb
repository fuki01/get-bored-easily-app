class TargetController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @user = User.find(params[:id])
    @day = Day.new
    @userDay = target_last_set
    @target = target_last_set
  end

  def new
    @user = User.new
    @target = Target.new
  end

  def create
    @user = User.find(current_user.id)
    @target = @user.targets.new(target_params)
    @target.user_id = current_user.id
    if @target.save
      redirect_to "/target/#{current_user.id}", notice: '目標を設定しました。'
    else
      redirect_to "/target/#{current_user.id}", notice: '目標を設定できませんでした。'
    end
  end

  def destroy
    @user = User.find(current_user.id)
    if target_last_set.destroy
      redirect_to target_path, notice: '目標を削除しました。'
    else
      redirect_to target_path, notice: '目標を削除できませんでした。'
    end
  end

  def edit
    @user = User.find(params[:id])
    @target = target_last_set
  end

  def update
    @user = User.find(params[:id])
    if target_last_set.update(target_params)
      redirect_to "/target/#{current_user.id}", notice: '目標を設定しました。'
    else
      redirect_to "/target/#{current_user.id}/edit", notice: '目標を設定できませんでした。'
    end
  end

  def list
    @targets = current_user.targets.all
  end
  private

  def target_last_set
    @user.targets.last
  end
  def target_params
    params.require(:target).permit(:body)
  end
end

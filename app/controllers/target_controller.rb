class TargetController < ApplicationController
  before_action :authenticate_user!
  before_action :clear_page,{only: [:clear]}
  before_action :target_nil, {only: [:show]}
  def index
    @targets = User.find(current_user.id).targets.all
    @target_false_count = User.find(current_user.id).targets.where(clear: false).count
  end

  def show
    @user = user_find_set
    @day = Day.new
    @target = Target.find(params[:id])
    if !@target.nil?
      if @target.clear
        redirect_to target_clear_path
      end
    end
  end

  def new
    @user = User.new
    @target = Target.new
  end

  def create
    @user = user_find_set
    @target = @user.targets.new(target_params)
    @target.user_id = current_user.id
    @target.clear = false
    if @target.save
      redirect_to "/target/#{@user.targets.last.id}", notice: '目標を設定しました。'
    else
      redirect_to target_index_path, notice: '目標を設定できませんでした。'
    end
  end

  def destroy
    @user = user_find_set
    if target_last_set.destroy
      redirect_to target_index_path, notice: '目標を削除しました。'
    else
      redirect_to target_index_path, notice: '目標を削除できませんでし。'
    end
  end

  def edit
    @user = user_find_set
    @target = target_last_set
  end

  def update
    @user = user_find_set
    if target_last_set.update(target_params)
      redirect_to "/target/#{current_user.id}", notice: '目標を設定しました。'
    else
      redirect_to "/target/#{current_user.id}/edit", notice: '目標を設定できませんでした。'
    end
  end

  def list
    @targets = current_user.targets.all
  end

  def clear
  end

  private

  def user_find_set
    User.find(current_user.id)
  end
  def target_last_set
    @user.targets.last
  end
  def target_params
    params.require(:target).permit(:body)
  end
end

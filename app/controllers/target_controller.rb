class TargetController < ApplicationController
  before_action :authenticate_user!
  before_action :clear_page,{only: [:clear]}
  before_action :target_nil, {only: [:show]}
  before_action :target_limit, {only: [:create]}
  def index
    @targets = User.find(current_user.id).targets.where(clear: false)
    @target_false_count = User.find(current_user.id).targets.where(clear: false).count
  end

  def show
    @user = user_find_set
    @day = Day.new
    @target = Target.find(params[:id])
    # dayが存在するかの判定　存在しなければ０
    if @user.targets.find(params[:id]).day.last.present?
      @day_count = @user.targets.find(params[:id]).day.count
    else
      @day_count = 0
    end
    # クリアページへの判定
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
      redirect_to target_index_path, notice: '目標を設定しました。'
    else
      redirect_to target_index_path, notice: '目標を設定できませんでした。'
    end
  end

  def destroy
    @user = user_find_set
    if target_set.destroy
      redirect_to target_index_path, notice: '目標を削除しました。'
    else
      redirect_to target_index_path, notice: '目標を削除できませんでし。'
    end
  end

  def edit
    @user = user_find_set
    @target = target_set
  end

  def update
    @user = user_find_set
    if target_set.update(target_params)
      redirect_to target_index_path, notice: '目標を設定しました。'
    else
      redirect_to target_index_path, notice: '目標を設定できませんでした。'
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
  def target_set
    @user.targets.find(params[:id])
  end
  def target_params
    params.require(:target).permit(:body)
  end
end

module TargetHelper
  def target_nil?
    @user.targets.last.nil?
  end
  def body
    @user.targets.last.body
  end
  def day_empty?
    @user.targets.last.day.empty?
  end
  def complete_today
     @user.targets.last.day.last.entryday.strftime("%Y%m%d").to_i != Time.now.strftime('%Y%m%d').to_i
  end
end

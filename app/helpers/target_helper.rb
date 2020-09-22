module TargetHelper
  def target_nil?
    @user.target.nil?
  end
  def body
    @user.target.body
  end
  def day_empty?
    @user.target.day.empty?
  end
  def complete_today
     @user.target.day.last.entryday.strftime("%Y%m%d").to_i != Time.now.strftime('%Y%m%d').to_i
  end
end

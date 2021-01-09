module PointHelper
  def user_point(other_user)
    Day.where(user_id: other_user.id).count * 100
  end
end

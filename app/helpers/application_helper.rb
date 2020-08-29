module ApplicationHelper
  def profile_img(user)
    user.image.file.nil?
  end
end

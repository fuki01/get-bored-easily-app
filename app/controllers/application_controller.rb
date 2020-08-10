class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resouce)
    root_path   #login後のpathを設定
  end
end

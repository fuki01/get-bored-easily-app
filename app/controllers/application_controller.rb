class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resouce)
    target_path(current_user.id)
  end
  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :username, :password, :password_confirmation, :image ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  def clear_page
    if ! (current_user.targets.last.day.last.count == 7)
      flash[:notice]="クリアーしていません。"
      redirect_to target_path(current_user.id)
    end
  end
end

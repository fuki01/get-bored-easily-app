class HomeController < ApplicationController
  before_action :login_user_ridirect,only: [:top]
  def top
  end
end

class PointController < ApplicationController
  def show
    @users = User.all
    @points = []
    @users.each do |user|
      @points.push([user.username, user.user_point(user) ,user.image])
    end
    @points = @points.sort{|a,b| a[1]<=>b[1]}.reverse
  end
end
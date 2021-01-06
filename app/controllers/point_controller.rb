class PointController < ApplicationController
  def show
    @users = User.all
    @points = Point.all
    @rank = []
    @users.each do |user|
      @point_sum = 0
      @points.each do |point|
        if user.id == point.User_id
          @point_sum += point.sum
        end
      end
      @rank.push([user.username, @point_sum, user.image])
    end
      @rank=@rank.sort{|a,b| a[1]<=>b[1]}.reverse
  end
end

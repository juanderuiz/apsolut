class UsersController < ApplicationController

def show
  @user = User.find(params[:id])
  @quarters = Quarter.where('user_id = ?', @user.id).order(:year, :quart)
  @meetings = Meeting.where('user_id = ?', @user.id).order(:day, :start).group_by(&:day)
end

end

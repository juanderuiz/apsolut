class UsersController < ApplicationController

def show
  @user = User.find(params[:id])
  @photo = Photo.where('user_id = ?', @user.id).last
  @quarters = Quarter.where('user_id = ?', @user.id).order(:year, :quart)
  @meetings = Meeting.where('user_id = ?', @user.id).order(:day, :start).group_by(&:day)
end

end

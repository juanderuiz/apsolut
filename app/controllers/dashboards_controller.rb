class DashboardsController < ApplicationController
  def show
  	@quarters = Quarter.all.order(:year, :quart).group_by(&:user_id)
  	@years = Quarter.uniq.pluck(:year).sort
    
    @meetings = Meeting.where("day >= ?", Date.today)
    @meetings_by_date = @meetings.order(:day, :start).group_by(&:day)

    #total_users = User.count
    total_users = User.where(:admin => false).order(name: :desc).count
    half = total_users/2
    if (total_users.modulo(2))>0 
      @users_fc = User.select("id").first(half) #Users for first column LG device
      @users_sc = User.select("id").last(half) #Users for second column
    else
      @users_fc = User.select("id").first(half+1) #Users for first column LG device
      @users_sc = User.select("id").last(half) #Users for second column
    end
    
    #@users_fc = User.select("id").first(total_users) #Users for first column LG device
    #@users_sc = User.select("id").last(total_users) #Users for second column
    @quarters_fc = Quarter.where(user_id: @users_fc).order(:year, :quart).group_by(&:user_id)
    @quarters_sc = Quarter.where(user_id: @users_sc).order(:year, :quart).group_by(&:user_id)
  end
end
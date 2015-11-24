class DashboardsController < ApplicationController
  def show
  	@quarters = Quarter.all.order(:year, :quart).group_by(&:user_id)
  	@years = Quarter.uniq.pluck(:year).sort
    
    @meetings = Meeting.where("day >= ?", Date.today)
    @meetings_by_date = @meetings.order(:day, :start).group_by(&:day)
  end
end
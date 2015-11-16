class DashboardsController < ApplicationController
  def show
  	@quarters = Quarter.all.order(:year, :quart).group_by(&:user_id)
  	@years = Quarter.uniq.pluck(:year)
  end
end
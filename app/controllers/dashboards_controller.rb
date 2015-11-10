class DashboardsController < ApplicationController
  def show
  	@quarters = Quarter.where('year = ?', 2015).order(:year, :quart).group_by(&:user_id)
  	#@quarters = Quarter.where('year = ?', 2015).order(:quart).group_by(&:user_id)
  	# Y si saco aqui, año a año, y lo represento con un id=2014 en el dashboard
  	#así incluso será más fácil hacer el hidden con el selector de años
  end
end
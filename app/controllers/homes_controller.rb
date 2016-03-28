class HomesController < ApplicationController
  before_action :authenticate_user!	
  before_filter :check_user_signed_in

  def show
  end

  private

  def check_user_signed_in
  	if user_signed_in?
  	  redirect_to dashboard_path
    end
  end

end
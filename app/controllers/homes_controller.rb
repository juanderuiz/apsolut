class HomesController < ApplicationController
  #before_filter :authenticate_user!
  #before_filter :check_user_signed_in

  def show
  end

  def start
  end

  private

  def check_user_signed_in
  	if user_signed_in?
  	  redirect_to dashboard_path
    end
  end

end
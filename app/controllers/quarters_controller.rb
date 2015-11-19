class QuartersController < ApplicationController
  before_action :get_user
  before_action :get_quarter, only: [:show, :edit, :destroy, :update]

  def create
    @owner = User.find(quarter_params[:user_id])
    #quarter_params[:user_id] = @owner.id

    if @owner 
      @quarter = @owner.quarters.new(quarter_params)
  	# Check fields
    respond_to do |format|
  	    if @quarter.save
  	      format.html { redirect_to root_url, notice: 'Quarter sucesfully added!' }
        else
          #format.html { redirect_to user_meetings_path, notice: 'Errors creating meeting' }
          format.html { render action: 'new' }
        end
    end
  else
  end
  end

  def new
  	@quarter = Quarter.new
  end

  def index
  	 
  end

  def show
  	
  end

  def edit
  
  end

  def update
    respond_to do |format|
      if @quarter.update(quarter_params)
        format.html { redirect_to root_url, notice: 'Quarter Updated!' }
        #format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        #format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    
  end

  private

  def quarter_params
  	params.require(:quarter).permit(:hours, :quart, :year, :user_id)
  end

  def get_user
      @user = User.find(params[:user_id])
  end

  def get_quarter
    @quarter = Quarter.find(params[:id]) || Quarter.new
  end
end
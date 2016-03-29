class MeetingsController < ApplicationController
  #before_filter :authenticate_user!
  before_action :get_user
  before_action :get_meeting, only: [:show, :edit, :destroy, :update]
  #Need to validate that a meeting is not overlapping another one

  def create
  	@meeting = current_user.meetings.build(meeting_params)
    #Check possible overlap

    @meetingsRD = Meeting.where("day = ? and room = ?", @meeting.day, @meeting.room)

  	# Check fields
    respond_to do |format|
  	    if @meeting.save
  	      format.html { redirect_to user_meetings_path, notice: 'Meeting sucesfully added!' + @meetingsRD.size().to_s }
        else
          #format.html { redirect_to user_meetings_path, notice: 'Errors creating meeting' }
          format.html { render action: 'edit' }
        end
    end
  end

  def new
  	#@meeting  = Meeting.new
  end

  def index
  	 @meeting = Meeting.new
     #Just show meetings for current day and future ones
     @meetings = Meeting.where("day >= ?", Date.today)
     @meetings_by_date = @meetings.order(:day, :start).group_by(&:day)
  end

  def show
  	#@meeting = Meeting.find(params[:id])
  end

  def edit
    #@meeting = Meeting.find(params[:id])
    if (@meeting.user_id != current_user.id)
      redirect_to user_meetings_path, notice: 'Sorry! Not your meeting'
    end
    @meetings = Meeting.where("day >= ?", Date.today)
    @meetings_by_date = @meetings.order(:day, :start).group_by(&:day)
    #@meetingsSameDay = Meeting.where("day = ? and room = ?", meeting_params[:day], meeting_params[:room])
  end

  def update
    #@meetingsRD = Meeting.where("day = ? and room = ? and (start <= ? and finish >= ?)", meeting_params[:day], meeting_params[:room], meeting_params[:start], meeting_params[:start])
    @meetingsRD = Meeting.where("day = ? and room = ?", meeting_params[:day], meeting_params[:room])

    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to user_meetings_path, notice: 'Meeting Updated!' + @meetingsRD.size().to_s }
        #format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        #format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #First, check current user is the owner
    if @meeting.user_id == current_user.id
      if @meeting.destroy
        respond_to do |format|
          format.html { redirect_to user_meetings_path(@user), notice: 'Meeting deleted!'}
          #format.json { head :no_content }
          #format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to user_meetings_path, notice: 'Sorry! Something happened...' }
          #format.json { head :no_content }
          #format.js
        end
      end
    else
      redirect_to user_meetings_path(@user), notice: 'Sorry, not your meeting...'
    end  
  end

  private

  def meeting_params
  	params.require(:meeting).permit(:subject, :day, :start, :finish, :room)
  end

  def get_user
      @user = User.find(params[:user_id])
  end

  def get_meeting
    @meeting = Meeting.find(params[:id]) || Meeting.new
  end
end
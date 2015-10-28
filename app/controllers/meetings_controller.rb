class MeetingsController < ApplicationController
  before_action :get_user
  before_action :get_meeting, only: [:show, :edit, :destroy, :update]
  #Need to validate that a meeting is not overlapping another one -> DONE

  def create
  	@meeting = current_user.meetings.build(meeting_params)
    #Check possible overlap

    @meetingsRD = Meeting.where("day = ? and room = ?", @meeting.day, @meeting.room)
    overlap = false
    @meetingsRD.each do |mtng|
       if ((@meeting.finish <= mtng.start) || (@meeting.start >= mtng.finish))
         overlap = false
       else
         overlap = true
         @meeting.errors[:start] << 'Overlap?'
         @meeting.errors[:finish] << 'Overlap?'
         break
       end
    end

  	# Check fields
    respond_to do |format|
  	    if !overlap && @meeting.save
  	      format.html { redirect_to user_meetings_path, notice: 'Meeting sucesfully added!' }
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
     @meetings = Meeting.all
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
  end

  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to user_meetings_path, notice: 'Meeting Updated!' }
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
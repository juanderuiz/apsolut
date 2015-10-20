class Meeting < ActiveRecord::Base
  #include ActiveModel::Validations
  #validates_with MeetingValidator

  belongs_to :user
  validates :user, :subject, :day, :start, :finish, :room, presence: true

  #Need to validate start < finish
  validates_datetime :finish, :on_or_after => :start

  #Meeting is today or in the future...
  validates_date :day, :on_or_after => lambda { Date.current }

  #If the meeting is for today... start must be after now... may with a method

  #Check that a new meeting does not overlap other meeting in the same room
  
end




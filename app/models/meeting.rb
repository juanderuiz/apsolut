class Meeting < ActiveRecord::Base
  validate :not_overlapping, on: [:create, :update]
  #include ActiveModel::Validations
  #validates_with MeetingValidator

  belongs_to :user
  validates :user, :subject, :day, :start, :finish, :room, presence: true

  #Need to validate start < finish
  validates_datetime :finish, :on_or_after => :start

  #Meeting is today or in the future...
  validates_date :day, :on_or_after => lambda { Date.current }

  #If the meeting is for today... start should be after now... but let's imagine
  #that we were in a hurry, the room was empty and we started a meeting, so we don't
  #want to be interrupted... and decide to book that meeting, so it will appear on
  #the system

  #Check that a new meeting does not overlap other meeting in the same room
  def not_overlapping
    @meetingsRD = Meeting.where("day = ? and room = ?", day, room)
    overlap = false
    @meetingsRD.each do |mtng|
      if (id != mtng.id)
        if ((finish <= mtng.start) || (start >= mtng.finish))
          overlap = false
        else
          overlap = true
          errors.add(:finish, 'Sorry! It overlaps ' + (mtng.subject).upcase + ' meeting')
          errors.add(:start, 'Sorry! It overlaps ' + (mtng.subject).upcase + ' meeting')
          break #if overlap, finish the loop
        end
      end
    end
  end

end




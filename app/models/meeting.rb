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

  #If the meeting is for today... start must be after now... may with a method

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
          if (finish > mtng.start)
            errors.add(:finish, 'Sorry! It overlaps ' + (mtng.subject).upcase + ' meeting')
          else
            errors.add(:start, 'Sorry! It overlaps ' + (mtng.subject).upcase + ' meeting')
          end
          break
        end
      end
    end
  end

end




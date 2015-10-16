class Meeting < ActiveRecord::Base
  belongs_to :user
  validates :user, :subject, :day, :start, :finish, :room, presence: true
  #Need to validate start < finish
  #Meeting is in the future...
end

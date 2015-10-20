class MeetingValidator < ActiveModel::Validator
  def validate(record)
    fecha = (record.day == Date.current)
    if fecha #so, we are today
      record.start > Time.now
      record.finish > record.start
    else
      record.errors[:start] << 'The start time is before now??'
    end
  end
end
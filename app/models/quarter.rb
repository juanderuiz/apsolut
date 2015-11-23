class Quarter < ActiveRecord::Base
  validate :quarter_not_exists, on: [:create]
  #validate :previous_quarter_is_created, on: [:create] #removed :update when changed the _editform.html.erb

  belongs_to :user
  validates :user, :year, :hours, :quart, presence: true

  def quarter_not_exists
    @quarter_not_created = Quarter.where("quart = ? and year = ? and user_id = ?", quart, year, user_id)
    if (@quarter_not_created.size() > 0)
      errors.add(:quart, 'Sorry! This quartet was previously created!')
    end
  end

  #This validation is not being used
  def previous_quarter_is_created
    @user_quarters = Quarter.where("user_id = ?", user_id)
    #if is the first quarter in the company... you can create it
    unless (@user_quarters.size() == 0)
  	  if (quart == 1)
        quart_required = 4
        year_required = year-1
      else
        quart_required = quart-1
        year_required = year
      end
      if
        logger.debug "Quart required -> #{quart_required} Year required -> #{year_required}"
        @previous_created = Quarter.where("quart = ? and year = ? and user_id = ?", quart_required, year_required, user_id)
        logger.debug "Quart found -> #{@previous_created.size()}"
        if (@previous_created.size() == 0)
      	  errors.add(:quart, 'Sorry! You have quarters to create BEFORE this one')
        end
      end 
    end
  end

end

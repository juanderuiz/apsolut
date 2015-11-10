class Quarter < ActiveRecord::Base
  validate :quarter_not_exists, on: [:create]
  validate :previous_quarter_is_created, on: [:create, :update]

  belongs_to :user
  validates :user, :year, :hours, :quart, presence: true

  def quarter_not_exists
    @quarter_not_created = Quarter.where("quart = ? and year = ? and user_id = ?", quart, year, user_id)
    if (@quarter_not_created.size() > 0)
      errors.add(:quart, 'Sorry! This quartet was previosly created!')
    end
  end

  def previous_quarter_is_created
  	if (quart > 1)
      quart_required = quart-1
      logger.debug "Quart required -> #{quart_required}"
      @previous_created = Quarter.where("quart = ? and year = ? and user_id = ?", quart_required, year, user_id)
      logger.debug "Quart found -> #{@previous_created.size()}"
      if (@previous_created.size() == 0)
      	errors.add(:quart, 'Sorry! You have quarters to create BEFORE this one')
      end
    end 
  end

end

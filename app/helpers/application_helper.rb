module ApplicationHelper
	def link_or_not(user, quart)
  	  if current_user.try(:admin?)
  	    link_to quart.hours, edit_user_quarter_path(user, quart) 
      else
        quart.hours
      end
    end
end

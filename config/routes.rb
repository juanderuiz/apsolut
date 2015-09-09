Rails.application.routes.draw do

  root 'photos#new'

  resources :photos do
  	get 'alert', :to => 'photos#alert'
  	#get 'allimages', :on => :collection
  end

  #get 'allimages' => 'photos#allimages', :as => 'allimages'
end

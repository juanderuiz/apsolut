Rails.application.routes.draw do

  root 'photos#index'

  resources :photos do
  	get 'allimages', :on => :collection
  end

  #get 'allimages' => 'photos#allimages', :as => 'allimages'
end

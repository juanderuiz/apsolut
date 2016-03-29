Rails.application.routes.draw do

  #devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'dashboards#show' #, via: :get

  resource :dashboard, only: [:show]

  resources :users do
  	get 'profile', on: :member
  	resources :meetings
  	resources :photos
  	resources :quarters
  end

end

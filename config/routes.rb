Rails.application.routes.draw do

  #devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'devise/sessions#new', via: :get

  resource :dashboard, only: [:show]

  resources :users do
  	get 'profile', on: :member
  	resources :meetings
  	resources :photos
  	resources :quarters
  end

end

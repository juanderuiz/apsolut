Rails.application.routes.draw do

  #devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations' }

  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  root 'homes#start'

  resource :dashboard, only: [:show]

  resources :users do
  	get 'profile', on: :member
  	resources :meetings
  	resources :photos
  	resources :quarters
  end

end

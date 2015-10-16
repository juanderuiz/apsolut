Rails.application.routes.draw do

  devise_for :users
  root 'homes#show', via: :get

  resource :dashboard, only: [:show]

  resources :users do
  	resources :meetings
  	resources :photos
  end

end

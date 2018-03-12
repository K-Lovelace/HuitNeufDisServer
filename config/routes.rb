Rails.application.routes.draw do
  post "/subscribe" => "subscription#create"
  post "/push" => "picking#push"

  get 'users/group_command'

  get 'picking/notifications'

  get 'picking/supervisor'

  root 'picking#notifications'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :armoires
  resources :articles
  resources :cases
  resources :commands
  resources :marquages
  resources :portes
  resources :users
end

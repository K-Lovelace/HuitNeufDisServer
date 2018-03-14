Rails.application.routes.draw do
  post "/subscribe" => "subscription#create"
  post "/push" => "picking#push"

  get 'users/:id/group_command(:format)' => "users#group_command"
  get 'users/:id/end_command(:format)' => "users#end_command"
  get 'cases/:id/take(:format)' => "cases#take"
  get 'cases/:id/empty(:format)' => "cases#empty"

  get 'picking/supervisor'

  root 'picking#stock'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :armoires
  resources :articles
  resources :cases
  resources :commands
  resources :marquages
  resources :portes
  resources :users
end

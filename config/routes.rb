Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :armoires
  resources :articles
  resources :cases
  resources :commands
  resources :marquages
  resources :portes
  resources :users
end

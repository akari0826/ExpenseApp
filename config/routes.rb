Rails.application.routes.draw do
  get 'expense_data/new'
  get 'sessions/new'
  
  root 'pages#index'
  get 'pages/help'
  
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  
  resources :users
  resources :expense_data
end
Rails.application.routes.draw do
  get 'sessions/new'
  
  root 'pages#index'
  get 'pages/help'
  
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  
  resources :users, only: [:new, :create]
  resources :expenses
  namespace :admin do
    resources :users, :expense_categories
    resources :expenses do
      member do
        get 'approval'
      end
    end  
  end
end
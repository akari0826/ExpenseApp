Rails.application.routes.draw do
  get 'sessions/new'
  
  root 'pages#index'
  get 'pages/help'

  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  
  # URLにトークンを持たせる & URLをasで別名を指定
  # get 'users/:token/authenticate_completed', to: 'users#authenticate_completed', as: :authenticate_completed
  
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
  
  resources :account_activations, only: [:edit]
end
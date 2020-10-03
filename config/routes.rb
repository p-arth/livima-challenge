Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, :path => 'auth', controllers: {confirmations: 'confirmations'}

  resources :users, :controller => 'users'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

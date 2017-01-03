Rails.application.routes.draw do
  root to: 'pages#home'
  get '/learn', to: 'pages#learn', as: 'learn'
  resources :posts
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :users
end

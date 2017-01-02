Rails.application.routes.draw do
  root to: 'pages#home'
  resources :posts
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :users
end

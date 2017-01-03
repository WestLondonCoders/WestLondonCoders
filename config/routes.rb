Rails.application.routes.draw do
  root to: 'pages#home'
  get '/learn', to: 'pages#learn', as: 'learn'
  resources :posts
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :users do
    collection do
      match 'search' => 'users#search', via: [:get, :post], as: :search
    end
  end
end

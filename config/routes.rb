Rails.application.routes.draw do
  root to: 'pages#home'
  get '/learn', to: 'pages#learn', as: 'learn'
  get '/jekyll', to: 'pages#jekyll', as: 'jekyll'
  resources :posts do
    collection do
      match 'search' => 'posts#search', via: [:get, :post], as: :search
    end
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :users do
    collection do
      match 'search' => 'users#search', via: [:get, :post], as: :search
    end
  end

  resources :interests do
    collection do
      match 'search' => 'interests#search', via: [:get, :post], as: :search
    end
  end

  resources :skills do
    collection do
      match 'search' => 'skills#search', via: [:get, :post], as: :search
    end
  end

  get '/users/:id/edit-interests', to: 'users#edit_interests', as: 'edit_interests'
  get '/users/:id/edit-skills', to: 'users#edit_skills', as: 'edit_skills'

end

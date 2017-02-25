Rails.application.routes.draw do
  resources :post_attachments
  root to: 'pages#home'
  get '/learn', to: 'pages#learn', as: 'learn'
  get '/jekyll', to: 'pages#jekyll', as: 'jekyll'
  get '/meetups', to: 'pages#meetups', as: 'meetups'
  get '/organisers', to: 'users#organisers', as: 'organisers'

  resources :posts do
    collection do
      match 'search' => 'posts#search', via: [:get, :post], as: :search
    end
    resources :comments
  end

  resources :comments do
    resources :comments
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

  get '/meetup-17-python-hackroom', to: redirect('/posts/python-hackroom-with-ali-hamdan', status: 302)
  get '/getting-a-job-in-software-development-shabbir-naqvi', to: redirect('http://westlondoncoders.com/posts/getting-a-job-in-software-development', status: 302)

  resources :languages do
    collection do
      match 'search' => 'languages#search', via: [:get, :post], as: :search
    end
  end

  resources :hackrooms do
    collection do
      match 'search' => 'hackrooms#search', via: [:get, :post], as: :search
    end
    member do
      get :join
      post :join
      get :leave
      post :leave
    end
  end
end

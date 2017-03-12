Rails.application.routes.draw do
  resources :post_attachments
  root to: 'pages#home'
  get '/learn', to: 'pages#learn', as: 'learn'
  get '/jekyll', to: 'pages#jekyll', as: 'jekyll'
  get '/organisers', to: 'users#organisers', as: 'organisers'
  get '/past-events', to: 'events#past_events', as: 'past_events'
  get '/events', to: redirect('meetups')

  resources :posts do
    collection do
      match 'search' => 'posts#search', via: [:get, :post], as: :search
    end
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  devise_for :users, controllers: { omniauth_callbacks: "callbacks", registrations: "registrations", passwords: "passwords", sessions: "sessions" }
  resources :users, path: 'members' do
    collection do
      match 'search' => 'users#search', via: [:get, :post], as: :search
    end
  end

  get '/users', to: redirect('members')

  resources :interests do
    collection do
      match 'search' => 'interests#search', via: [:get, :post], as: :search
    end
  end

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
    end
  end

  resources :roles

  resources :sponsors

  resources :events, path: 'meetups' do
    collection do
      match 'search' => 'events#search', via: [:get, :post], as: :search
    end
    member do
      get :rsvp
      post :rsvp
    end
  end

  resources :organiser_interests, only: [:create]

  namespace :admin do
    root to: 'users#index'

    resources :users do
      collection do
        match 'search' => 'users#search', via: [:get, :post], as: :search
      end
    end

    resources :roles

    resources :events do
      collection do
        match 'search' => 'events#search', via: [:get, :post], as: :search
      end
    end

    get 'your-events', to: 'events#your_events'

    resources :sponsors
  end
end

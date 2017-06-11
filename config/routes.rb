Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :post_attachments
  root to: 'pages#home'
  get '/learn', to: 'pages#learn', as: 'learn'
  get '/jekyll', to: 'pages#jekyll', as: 'jekyll'
  get '/organisers', to: 'users#organisers', as: 'organisers'
  get '/past-meetups', to: 'meetups#past_meetups', as: 'past_meetups'
  get 'events', to: redirect('meetups')

  resources :posts do
    collection do
      match 'search' => 'posts#search', via: [:get, :post], as: :search
    end
    resources :comments
    member do
      get :announce
    end
  end

  resources :comments do
    resources :comment_replies do
      member do
        get :hide
      end
    end
  end

  get 'comments/:id/hide', to: 'comments#hide', as: :hide_comment

  resources :tags

  devise_for :users, controllers: { omniauth_callbacks: "callbacks", registrations: "registrations", passwords: "passwords", sessions: "sessions" }
  resources :users, path: 'members' do
    collection do
      match 'search' => 'users#search', via: [:get, :post], as: :search
    end
    member do
      get :follow
      post :follow
      get :unfollow
      post :unfollow
    end
  end

  get "/users/:id/user-languages" => 'users#languages', as: 'user_languages'
  get "/users/:id/user-hackrooms" => 'users#hackrooms', as: 'user_hackrooms'
  get "/users/:id/user-meetups" => 'users#meetups', as: 'user_meetups'
  get "/users/:id/user-pages" => 'users#posts', as: 'user_posts'

  get '/users', to: redirect('members')

  get '/meetup-17-python-hackroom', to: redirect('/posts/python-hackroom-with-ali-hamdan', status: 302)
  get '/getting-a-job-in-software-development-shabbir-naqvi', to: redirect('http://westlondoncoders.com/posts/getting-a-job-in-software-development', status: 302)

  resources :languages do
    collection do
      match 'search' => 'languages#search', via: [:get, :post], as: :search
    end
    resources :comments
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

  resources :meetups, path: 'meetups' do
    collection do
      match 'search' => 'meetups#search', via: [:get, :post], as: :search
    end
    member do
      get :rsvp
      post :rsvp
    end
  end

  resources :organiser_interests, only: [:create]

  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  get 'notifications/mark_all_read', to: 'notifications#mark_all_read', as: :mark_all_read
  resources :notifications, only: :index

  namespace :admin do
    root to: 'users#index'

    resources :users do
      collection do
        match 'search' => 'users#search', via: [:get, :post], as: :search
      end
    end

    resources :roles

    resources :meetups do
      collection do
        match 'search' => 'meetups#search', via: [:get, :post], as: :search
      end
    end

    get 'your-meetups', to: 'meetups#your_meetups'

    resources :sponsors
  end
end

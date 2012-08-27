BetterJsDemo::Application.routes.draw do
  
  get "sessions/new"

  get "sessions/create"

  get "sessions/failure"

  root :to => 'home#index'
  
  namespace :api do
    resources :users
    
    resources :blogs do
      resources :blog_posts
    end
    
    resources :blog_posts
    
    namespace :meta do
      resources :types
    end

    match 'auth' => 'auth#index'
    
    match 'search/tag/:tag' => 'search#tag'
    match 'search/trending' => 'search#trending'
    match 'search/:search_text' => 'search#index'
  end
  
  get '/login', :to => 'sessions#new', :as => :login
  get '/logout', :to => 'sessions#destroy'
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'
end

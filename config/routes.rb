Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  root "users#index"
  resources :users do
    get '/enroll_event/:event_id', to: 'users#enroll_event', as: 'enroll_event', on: :member
    get '/discard_enrolled_event/:event_id', to: 'users#discard_enrolled_event', as: 'discard_enrolled_event', on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

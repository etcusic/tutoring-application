Rails.application.routes.draw do
  
  root 'application#home'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  get '/auth/facebook/callback' => 'sessions#create_with_omniauth'

  # get '/tutors/highest_rated' => 'tutors#highest_rated'
  # get '/tutors' => 'tutors#index'
  # get '/appointments/soonest_available' => 'appointments#soonest_available - if tutors can set up availability

  resources :users do
    resources :appointments
  end 

  resources :students, only: [:update]
  resources :tutors, only: [:index, :update, :highest_rated]

  # resources :tutors do
  #   resources :appointments
  # end 

  # resources :students do
  #   resources :appointments
  # end 

  # resources :appointments # or should I only put appointment resource in nested routes??? 

  # root 'application#home'
end

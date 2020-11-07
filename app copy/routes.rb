Rails.application.routes.draw do
  
  root 'application#home'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  get '/auth/facebook/callback' => 'sessions#create_with_omniauth'
  
  get '/tutors/highest_rated' => 'tutors#highest_rated'
  # get '/appointments/soonest_available' => 'appointments#soonest_available

  resources :users do
    resources :appointments
  end 

  resources :tutors do
    resources :appointments
  end 

  resources :students do
    resources :appointments
  end 

  resources :appointments # or should I only put appointment resource in nested routes??? 

end
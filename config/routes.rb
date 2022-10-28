Rails.application.routes.draw do
  get 'sessions/new'
  get 'session/new'
  resources :microposts
  resources :users

  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'

  get '/register', to:'users#new', as:'register'
  get '/login', to:'sessions#new', as:'login'
  post '/login', to:'sessions#create', as:'sign_in'
  delete '/logout', to:'sessions#destroy', as:'logout'

  root 'static_pages#home'


end
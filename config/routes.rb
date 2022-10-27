Rails.application.routes.draw do
  resources :microposts
  resources :users

  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'

  get '/register', to:'users#new', as:'register'
  get '/login', to:'session#new', as:'login'

  root 'static_pages#home'


end
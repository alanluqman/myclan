Rails.application.routes.draw do
  # root path is '/' or '/users'
  root 'users#index'

  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  get '/users/:id/posts', to: 'posts#index'
  get '/users/:id/posts/:id', to: 'posts#show'
end

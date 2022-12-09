Rails.application.routes.draw do
  # root path is '/' or '/users'
  root 'users#index'

  resources :users do
    resources :posts
  end
end

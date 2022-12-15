Rails.application.routes.draw do
  # root path is '/' or '/users'
  root 'users#index'
  devise_for :users
  delete '/users/sign_out', to: 'devise/sessions#destroy', as: 'logout'
  resources :users do
    resources :posts do
      resources :comments
      resources :likes
    end
  end
end

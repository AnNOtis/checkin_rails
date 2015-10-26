Rails.application.routes.draw do
  devise_for :user

  namespace :api, defaults: { format: 'json' }  do
    namespace :v1 do
      resources :checkins, only: [:index]
      namespace :device do
        resources :checkins, only: [:create, :update, :destroy]
        resources :followings, only: [:create]
      end
      resources :registrations, only: [:create]
      resources :users, only: [:login] do
        post 'login', on: :collection
      end
    end
  end
end

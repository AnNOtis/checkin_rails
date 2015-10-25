Rails.application.routes.draw do
  devise_for :user

  namespace :api, defaults: { format: 'json' }  do
    namespace :v1 do
      resources :registrations, only: [:create]
      resources :checkins, only: [:index]
      namespace :device do
        resources :checkins, only: [:create, :update, :destroy]
        resources :followings, only: [:create]
      end
    end
  end
end

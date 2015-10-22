Rails.application.routes.draw do
  devise_for :user

  namespace :api, defaults: { format: 'json' }  do
    namespace :v1 do
      resources :registrations, only: [:create]

      namespace :device do
        resources :checkins, only: [:index, :create, :update, :destroy]
        resources :followings, only: [:create]
      end
    end
  end
end

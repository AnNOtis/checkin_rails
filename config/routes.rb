Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' }  do
    namespace :v1 do
      resources :registrations, only: [:create]
      resources :checkins, only: [:index, :create, :update, :destroy]
    end
  end
end

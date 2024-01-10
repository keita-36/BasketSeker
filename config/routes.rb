Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }

  root "static_pages#top"
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms', to: 'static_pages#terms'

  resources :events do
    resources :match_results, only: [:create, :destroy, :new]
    resources :user_events, only: [:create, :destroy]
    resources :rooms, only: [:show]
  end

  resources :match_results, only: [:index]
  resource :profile, only: %i[edit show update]
  resources :event_attendances, only: [:create, :destroy]

  resources :notifications, only: %i[index destroy] 

end

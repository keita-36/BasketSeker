Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }

  root "static_pages#top"

  resources :events do
    resources :match_results, only: [:create, :destroy, :new]
    resources :user_events, only: [:create, :destroy]
  end

  resources :match_results, only: [:index]
  resource :profile, only: %i[edit show update]
  resources :event_attendances, only: [:create, :destroy]
end

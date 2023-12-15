Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }

  root "static_pages#top"

  resources :events, only: [:show, :edit, :update, :destroy, :new, :create, :index] do
    resources :user_events, only: [:create, :destroy]
  end
end

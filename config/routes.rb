Rails.application.routes.draw do
  devise_for :users
  root "static_pages#top"

  resources :events, only: [:show, :edit, :update, :destroy, :new, :create, :index] 
end

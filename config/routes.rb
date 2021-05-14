Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:index, :create, :show, :destroy]
  resources :users, only: [:show, :edit, :update, :index]
end
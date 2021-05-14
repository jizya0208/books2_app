Rails.application.routes.draw do
  get 'homes/top'

  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:index, :create, :show, :destroy]
end
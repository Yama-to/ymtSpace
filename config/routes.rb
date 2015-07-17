Rails.application.routes.draw do

  devise_for :users

  root 'prototypes#index'
  resources :prototypes
  resources :users,     only: :show
  resources :comments,  only: :create
  resources :tags,      only: :index

end

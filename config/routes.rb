Rails.application.routes.draw do

  devise_for :users

  root 'prototypes#index'

  resources :prototypes
  resources :users,     only: :show
  resources :tags,      only: :index

  namespace :prototypes do
    resources :comments,  only: :create
  end

end

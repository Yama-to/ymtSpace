Rails.application.routes.draw do
  # for devise use
  devise_for :users

  # standard routings
  resources  :users,       only: [:show, :edit, :update]
  resources  :tags,        only: [:index, :show]
  resources  :prototypes,  except: [:destroy]

  # add prefix to controllers
  scope module: :prototypes do
    resources :newest,     only: [:index], as: :newest_prototypes
    resources :popular,    only: [:index], as: :popular_prototypes
    resources :comments,   only: [:create]
    resources :likes,      only: [:create, :update]
  end

  # root_path must be placed on the bottom of routes
  root 'prototypes#index'
end

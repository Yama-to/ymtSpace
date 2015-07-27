Rails.application.routes.draw do

  # for devise use
  devise_for :users

  root 'prototypes#index'

  resources :users,       only: [:show, :edit, :update]
  resources :tags,        only: [:index, :show]
  resources :prototypes,  except: [:destroy]

  # add prefix to controllers
  scope module: :prototypes do
    resources :newest,    only: [:index], as: :newest_prototypes
    resources :popular,   only: [:index], as: :popular_prototypes
    resources :comments,  only: [:create]
    resources :likes,     only: [:create, :update]
  end

  ## older-version
  # add 2 actions other than resources
  # resources :prototypes,  except: [:destroy] do
  #   collection do
  #     get 'newest'
  #     get 'popular'
  #   end
  # end

end

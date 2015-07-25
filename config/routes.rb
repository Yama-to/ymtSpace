Rails.application.routes.draw do

  # for devise use
  devise_for :users

  root 'prototypes#index'

  resources :users,       only: [:show, :edit, :update]
  resources :tags,        only: [:index, :show]


  # add 2 actions other than resources
  resources :prototypes, except: [:destroy] do
    collection do
      get 'newest'
      get 'popular'
    end
  end

  # add prefix to comments & likes controller
  scope module: :prototypes do
    resources :comments,  only: [:create]
    resources :likes,     only: [:create, :update]
  end

end

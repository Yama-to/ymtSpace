Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: :registrations}#, skip: [:sessions, :registration]
  # as :user do
  #   match '/users/sign_in/new'  =>   'devise/sessions#new',           via: [:get, :post, :patch, :delete], as: :new_user_session
  #   match '/users/sign_in'      =>   'devise/sessions#create',        via: [:get, :post, :patch, :delete], as: :create_user_session
  #   match '/users/sign_out'     =>   'devise/sessions#destroy',       via: [:get, :post, :patch, :delete], as: :destroy_user_session
  #   match '/users/cancel'       =>   'devise/registrations#cancel',   via: [:get, :post, :patch, :delete], as: :cancel_user_registration
  #   match '/users/sign_up/new'  =>   'devise/registrations#create',   via: [:get, :post, :patch, :delete], as: :create_user_registration
  #   match '/users/sign_up'      =>   'devise/registrations#new',      via: [:get, :post, :patch, :delete], as: :new_user_registration
  #   match '/users/edit'         =>   'devise/registrations#edit',     via: [:get, :post, :patch, :delete], as: :edit_user_registration
  #   match '/users/updte'        =>   'devise/registrations#update',   via: [:get, :post, :patch, :delete], as: :update_user_registration
  #   match '/users/delete'       =>   'devise/registrations#destroy',  via: [:get, :post, :patch, :delete], as: :destroy_user_registration
  # end

  root 'prototypes#index'

  resources :prototypes
  resources :users,       only: :show
  resources :tags,        only: :index

  namespace :prototypes do
    resources :comments,  only: :create
  end

end

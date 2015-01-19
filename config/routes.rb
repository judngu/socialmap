Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  root 'homes#index'

  resources :events, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :picks, only: [:index, :create]
  end

  resources :homes, only: [:index]
  resources :attendees, only: [:create]
  resource :user, only: [:show]
end

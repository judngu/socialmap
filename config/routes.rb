Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
 
  root 'homes#index'
  resources :events do
    resources :picks
  end
  resources :picks
  resources :homes
  resources :attendees
  resources :user
end

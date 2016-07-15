Rails.application.routes.draw do
  resources :contact_forms
  get "allnear", to: "static#allnear"
  get "about", to: "static#about", as: :about
  get "donate", to: "static#donate", as: :donate
  get "rankings", to: "static#rankings", as: :rankings
  get "privacy", to: "static#privacy", as: :privacy
  resources :pokemons
  resources :pokespawns, only: [:index, :new, :create]
  resources :pokestops, only: [:index, :new, :create]
  resources :gyms, only: [:index, :new, :create]
  devise_for :users, class_name: 'FormUser', :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static#home'
end

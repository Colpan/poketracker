Rails.application.routes.draw do
  resources :contact_forms
  get "allnear", to: "static#allnear"
  get "about", to: "static#about", as: :about
  get "donate", to: "static#donate", as: :donate
  resources :pokemons
  resources :pokespawns
  resources :pokestops
  resources :gyms
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static#home'
end

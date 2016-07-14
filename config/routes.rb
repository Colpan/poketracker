Rails.application.routes.draw do
  get "allnear", to: "static#allnear"
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

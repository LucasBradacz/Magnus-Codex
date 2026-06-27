Rails.application.routes.draw do
  resources :personagems
  get "home/index"
  resources :modificadors
  resources :transmutacaos
  resources :formas
  get "modificadors/index"
  get "modificadors/show"
  get "modificadors/new"
  get "modificadors/edit"
  get "transmutacaos/index"
  get "transmutacaos/show"
  get "transmutacaos/new"
  get "transmutacaos/edit"
  get "formas/index"
  get "formas/show"
  get "formas/new"
  get "formas/edit"

  root "home#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
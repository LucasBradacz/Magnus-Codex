Rails.application.routes.draw do
  get "encantamentos/index"
  get "encantamentos/show"

  resources :personagens, controller: "personagems" do
    resource :cartas_conhecidas, only: [:edit, :update], controller: "cartas_conhecidas"
    resources :encantamentos, only: [:new, :create] do
      collection { post :preview }
    end
  end

  resources :encantamentos, only: [:new, :create] do
    collection { post :preview }
  end
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
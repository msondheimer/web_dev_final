Chipsahoy::Application.routes.draw do
  root "pages#home"

  resources :users
  resources :sessions

  get "/logout" => "sessions#destroy", as: 'logout'

  get "/sports" => "pages#sports"
  get "/foods" => "pages#foods"
  get "/places" => "pages#places"


end

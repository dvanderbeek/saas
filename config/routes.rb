Saas::Engine.routes.draw do
  resources :accounts
  resources :pricing, only: :index
end

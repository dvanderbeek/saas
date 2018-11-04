Saas::Engine.routes.draw do
  resources :pricing, only: :index
  resource :subscription, only: [:edit, :create, :update]
end

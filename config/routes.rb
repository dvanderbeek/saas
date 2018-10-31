Saas::Engine.routes.draw do
  resources :products, only: [:index, :show]
  resources :pricing, only: :index
end

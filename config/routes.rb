Saas::Engine.routes.draw do
  resources :plans
  resources :products
  resources :pricing, only: :index
end

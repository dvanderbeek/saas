Saas::Engine.routes.draw do
  resources :pricing, only: :index
end

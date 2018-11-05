Saas::Engine.routes.draw do
  mount StripeEvent::Engine, at: '/stripe/events'
  resources :pricing, only: :index
  resource :subscription, only: [:edit, :create, :update]
end

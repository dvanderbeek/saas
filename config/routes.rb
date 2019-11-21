Saas::Engine.routes.draw do
  mount StripeEvent::Engine, at: '/stripe/events'
  resources :pricing, only: :index
  resource :subscription, only: [:edit, :create, :update]
  patch '/subscription/cancel', to: 'subscriptions#cancel', as: :cancel_subscription
  patch '/subscription/resume', to: 'subscriptions#resume', as: :resume_subscription
end

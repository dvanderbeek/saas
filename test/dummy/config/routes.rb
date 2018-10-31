Rails.application.routes.draw do
  mount Saas::Engine => "/saas"
  root to: 'home#index'
end

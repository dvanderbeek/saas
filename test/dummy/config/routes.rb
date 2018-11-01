Rails.application.routes.draw do
  devise_for :users
  mount Saas::Engine => "/saas"
  root to: 'home#index'
end

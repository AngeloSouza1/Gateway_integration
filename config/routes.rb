Rails.application.routes.draw do
  resources :gateways
  root "gateways#index"
end

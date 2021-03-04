Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: redirect("/products")
  resources :products, only: %i(index show)
  resources :orders, only: %i(new create show)
end

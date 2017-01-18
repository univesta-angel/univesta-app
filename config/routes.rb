Rails.application.routes.draw do
  resources :products
  root :to => 'products#index'
  match 'create' => 'products#create', via: :post
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
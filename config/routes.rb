Rails.application.routes.draw do

  get 'my_products/index'

  resources :products 
  root :to => 'products#index'
  match 'create' => 'products#create', via: :post
  post 'push' => 'products#push', as: :push
  get '/myproducts' => 'my_products#index'

  #post 'products#push'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
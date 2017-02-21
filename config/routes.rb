Rails.application.routes.draw do

  get 'orders' => 'order#index', as: :orders
  post 'products/bulkaction'
  get 'my_products/index'

  resources :products do
    post 'select_action'
    delete 'destroy_all_items'
  end
  
  root :to => 'products#index'
  match 'create' => 'products#create', via: :post
  post 'push' => 'products#push', as: :push
  post 'push_all' => 'products#push', as: :push_all
  get 'myproducts' => 'my_products#index'
  get 'orderlist' => 'products#order', as: :orderlist

  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

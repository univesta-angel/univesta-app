Rails.application.routes.draw do

  get 'orders' => 'order#index', as: :orders
  post 'products/bulkaction'
  get 'my_products' => 'my_products#index', as: :my_products

  resources :products do
    post 'select_action'
  end
  get "/fetch_orders" => "orders#from_category", as: "fetch_orders"
  root :to => 'products#index'
  
  match 'create' => 'products#create', via: :post
  
  post 'push' => 'products#push', as: :push
  post 'pushall' => 'products#push_all', as: :pushall
  
  post 'edit_price' => 'products#edit_price', as: :edit_price
  post 'edit_cap' => 'products#edit_cap', as: :edit_cap
  post 'multiply_price' => 'products#multiply_price', as: :multiply_price
  post 'multiply_cap' => 'products#multiply_cap', as: :multiply_cap
  delete 'remove_all' => 'products#remove_all', as: :remove_all
  delete 'imports_remove' => 'products#remove_selected', as: :remove_selected
  
  delete 'my_products/:id' => 'my_products#destroy', as: :destroy_product

  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

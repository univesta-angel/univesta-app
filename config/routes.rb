Rails.application.routes.draw do

  get 'orders' => 'order#index', as: :orders
  post 'products/bulkaction'
  get 'my_products/index'

  resources :products do
    post 'select_action'
    delete 'destroy_all_items'
  end
  
  root :to => 'products#index'
  
  get 'myproducts' => 'my_products#index'
  
  match 'create' => 'products#create', via: :post
  
  post 'push' => 'products#push', as: :push
  post 'push_all' => 'products#push', as: :push_all
  
  post 'edit_price' => 'imports#edit_price', as: :edit_price
  post 'edit_cap' => 'imports#edit_cap', as: :edit_cap
  delete 'remove_all' => 'imports#remove_all', as: :remove_all
  delete 'imports_remove' => 'imports#remove_selected', as: :remove_selected
  

  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do

  resources :products do
    post 'select_action'
  end
  
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
  
  post 'products/bulkaction'
  get 'my_products' => 'my_products#index', as: :my_products
  delete 'my_products/:id' => 'my_products#destroy', as: :destroy_product

  get '/settings' => 'settings#index'
  put '/settings/edit_markup' => 'settings#edit_markup'

  get 'orders' => 'order#index', as: :orders
  get "/fetch_orders" => "order#from_category", as: :fetch_orders
  put "/edit_note" => "order#edit_note", as: :edit_note
  post "/mark_shipped" => "order#mark_shipped", as: :mark_shipped

  get '/notifications' => 'notification#index', as: :notifications
  match '/notifications/create_notif' => 'notification#create_notif', via: :post
  
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

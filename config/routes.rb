Rails.application.routes.draw do

  get 'order/index'

  get 'my_products/index'

  resources :products do
<<<<<<< HEAD
  	delete 'destroy_multiple'
  end

=======
    post 'select_action'
    delete 'destroy_all_items'
  end
  
  root :to => 'products#index'
>>>>>>> 9c80e86e4be127f9a8d4bb1c571fdd83bd0fe042
  match 'create' => 'products#create', via: :post
  post 'push' => 'products#push', as: :push
  post 'push_all' => 'products#push', as: :push_all
  get 'myproducts' => 'my_products#index'
  get 'orderlist' => 'products#order', as: :orderlist

  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

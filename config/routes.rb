Rails.application.routes.draw do

  get 'order/index'

  get 'my_products/index'

  resources :products do
  	delete 'destroy_multiple'
  end

  match 'create' => 'products#create', via: :post
  post 'push' => 'products#push', as: :push
  get '/myproducts' => 'my_products#index'

  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
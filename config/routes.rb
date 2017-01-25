Rails.application.routes.draw do
  get 'tabs/variants'

  get 'tabs/images'

  resources :products 
  root :to => 'products#index'
  match 'create' => 'products#create', via: :post
  post 'push' => 'products#push', as: :push
  #post 'products#push'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
ShopifyApp.configure do |config|

  config.api_key = "345caeafea49d80e0f40194dd9a721c5"
  config.secret = "43f67e64209c57cb6ba9116a9a79be9d"
  config.scope = "read_orders, read_products, write_products"
  config.scope = "read_orders, write_orders, read_products, write_products, read_customers, write_customers, read_fulfillments, write_fulfillments"
  config.embedded_app = false
end
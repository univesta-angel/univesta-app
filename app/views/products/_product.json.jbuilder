json.extract! product, :id, :title, :body_html, :images, :product_type, :tags, :vendor, :created_at, :updated_at
json.url product_url(product, format: :json)
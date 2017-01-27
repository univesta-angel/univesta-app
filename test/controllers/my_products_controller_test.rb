require 'test_helper'

class MyProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_products_index_url
    assert_response :success
  end

end

require 'test_helper'

class TabsControllerTest < ActionDispatch::IntegrationTest
  test "should get variants" do
    get tabs_variants_url
    assert_response :success
  end

  test "should get images" do
    get tabs_images_url
    assert_response :success
  end

end

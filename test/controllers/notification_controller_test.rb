require 'test_helper'

class NotificationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get notification_index_url
    assert_response :success
  end

  test "should get create_notif" do
    get notification_create_notif_url
    assert_response :success
  end

  test "should get update_price" do
    get notification_update_price_url
    assert_response :success
  end

end

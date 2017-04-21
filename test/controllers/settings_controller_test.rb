require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get settings_index_url
    assert_response :success
  end

  test "should get edit_markup" do
    get settings_edit_markup_url
    assert_response :success
  end

end

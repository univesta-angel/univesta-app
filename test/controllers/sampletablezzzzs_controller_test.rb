require 'test_helper'

class SampletablezzzzsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sampletablezzzz = sampletablezzzzs(:one)
  end

  test "should get index" do
    get sampletablezzzzs_url
    assert_response :success
  end

  test "should get new" do
    get new_sampletablezzzz_url
    assert_response :success
  end

  test "should create sampletablezzzz" do
    assert_difference('Sampletablezzzz.count') do
      post sampletablezzzzs_url, params: { sampletablezzzz: { age: @sampletablezzzz.age, id: @sampletablezzzz.id, name: @sampletablezzzz.name } }
    end

    assert_redirected_to sampletablezzzz_url(Sampletablezzzz.last)
  end

  test "should show sampletablezzzz" do
    get sampletablezzzz_url(@sampletablezzzz)
    assert_response :success
  end

  test "should get edit" do
    get edit_sampletablezzzz_url(@sampletablezzzz)
    assert_response :success
  end

  test "should update sampletablezzzz" do
    patch sampletablezzzz_url(@sampletablezzzz), params: { sampletablezzzz: { age: @sampletablezzzz.age, id: @sampletablezzzz.id, name: @sampletablezzzz.name } }
    assert_redirected_to sampletablezzzz_url(@sampletablezzzz)
  end

  test "should destroy sampletablezzzz" do
    assert_difference('Sampletablezzzz.count', -1) do
      delete sampletablezzzz_url(@sampletablezzzz)
    end

    assert_redirected_to sampletablezzzzs_url
  end
end

require 'test_helper'

class SampletablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sampletable = sampletables(:one)
  end

  test "should get index" do
    get sampletables_url
    assert_response :success
  end

  test "should get new" do
    get new_sampletable_url
    assert_response :success
  end

  test "should create sampletable" do
    assert_difference('Sampletable.count') do
      post sampletables_url, params: { sampletable: { age: @sampletable.age, name: @sampletable.name } }
    end

    assert_redirected_to sampletable_url(Sampletable.last)
  end

  test "should show sampletable" do
    get sampletable_url(@sampletable)
    assert_response :success
  end

  test "should get edit" do
    get edit_sampletable_url(@sampletable)
    assert_response :success
  end

  test "should update sampletable" do
    patch sampletable_url(@sampletable), params: { sampletable: { age: @sampletable.age, name: @sampletable.name } }
    assert_redirected_to sampletable_url(@sampletable)
  end

  test "should destroy sampletable" do
    assert_difference('Sampletable.count', -1) do
      delete sampletable_url(@sampletable)
    end

    assert_redirected_to sampletables_url
  end
end

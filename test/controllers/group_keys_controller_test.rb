require 'test_helper'

class GroupKeysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_key = group_keys(:one)
  end

  test "should get index" do
    get group_keys_url, as: :json
    assert_response :success
  end

  test "should create group_key" do
    assert_difference('GroupKey.count') do
      post group_keys_url, params: { group_key: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show group_key" do
    get group_key_url(@group_key), as: :json
    assert_response :success
  end

  test "should update group_key" do
    patch group_key_url(@group_key), params: { group_key: {  } }, as: :json
    assert_response 200
  end

  test "should destroy group_key" do
    assert_difference('GroupKey.count', -1) do
      delete group_key_url(@group_key), as: :json
    end

    assert_response 204
  end
end

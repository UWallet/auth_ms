require 'test_helper'

class GroupKesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_ke = group_kes(:one)
  end

  test "should get index" do
    get group_kes_url, as: :json
    assert_response :success
  end

  test "should create group_ke" do
    assert_difference('GroupKe.count') do
      post group_kes_url, params: { group_ke: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show group_ke" do
    get group_ke_url(@group_ke), as: :json
    assert_response :success
  end

  test "should update group_ke" do
    patch group_ke_url(@group_ke), params: { group_ke: {  } }, as: :json
    assert_response 200
  end

  test "should destroy group_ke" do
    assert_difference('GroupKe.count', -1) do
      delete group_ke_url(@group_ke), as: :json
    end

    assert_response 204
  end
end

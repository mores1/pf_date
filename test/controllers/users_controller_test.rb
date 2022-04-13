require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_edit_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get users_unsubscribe_url
    assert_response :success
  end

  test "should get withdrow" do
    get users_withdrow_url
    assert_response :success
  end
end

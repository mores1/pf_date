require "test_helper"

class SpotPlansControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get spot_plans_show_url
    assert_response :success
  end
end

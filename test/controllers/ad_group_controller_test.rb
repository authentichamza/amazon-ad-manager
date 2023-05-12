require "test_helper"

class AdGroupControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ad_group_index_url
    assert_response :success
  end

  test "should get show" do
    get ad_group_show_url
    assert_response :success
  end
end

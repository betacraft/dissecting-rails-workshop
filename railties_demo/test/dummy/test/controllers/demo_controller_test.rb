require "test_helper"

class DemoControllerTest < ActionDispatch::IntegrationTest
  test "should get sample" do
    get demo_sample_url
    assert_response :success
  end
end

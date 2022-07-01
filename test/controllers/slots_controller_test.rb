require "test_helper"

class SlotsControllerTest < ActionDispatch::IntegrationTest
  test "should get enlist" do
    get slots_enlist_url
    assert_response :success
  end
end

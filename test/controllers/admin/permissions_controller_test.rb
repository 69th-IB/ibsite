require "test_helper"

class Admin::PermissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_permissions_index_url
    assert_response :success
  end
end

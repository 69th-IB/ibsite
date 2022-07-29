require "test_helper"

class ServerConfigsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get server_configs_index_url
    assert_response :success
  end

  test "should get show" do
    get server_configs_show_url
    assert_response :success
  end

  test "should get edit" do
    get server_configs_edit_url
    assert_response :success
  end

  test "should get update" do
    get server_configs_update_url
    assert_response :success
  end
end

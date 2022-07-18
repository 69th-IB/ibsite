require "test_helper"

class ModlistsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get modlists_index_url
    assert_response :success
  end

  test "should get show" do
    get modlists_show_url
    assert_response :success
  end

  test "should get create" do
    get modlists_create_url
    assert_response :success
  end

  test "should get update" do
    get modlists_update_url
    assert_response :success
  end

  test "should get delete" do
    get modlists_delete_url
    assert_response :success
  end
end

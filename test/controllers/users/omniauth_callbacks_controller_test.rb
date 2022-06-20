require "test_helper"

class Users::OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get discord" do
    get users_omniauth_callbacks_discord_url
    assert_response :success
  end

  test "should get steam" do
    get users_omniauth_callbacks_steam_url
    assert_response :success
  end
end

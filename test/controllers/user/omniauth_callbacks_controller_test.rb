require "test_helper"

class User::OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get discord" do
    get user_omniauth_callbacks_discord_url
    assert_response :success
  end

  test "should get steam" do
    get user_omniauth_callbacks_steam_url
    assert_response :success
  end
end

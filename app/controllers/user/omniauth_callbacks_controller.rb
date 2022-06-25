class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def discord
    pp request.env["omniauth.auth"]
    @user = User.from_discord(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Discord") if is_navigational_format?
    else
      pp request.env["omniauth.auth"]
    end
  end

  def steam
    pp request.env["omniauth.auth"]
  end

  def developer
    raise "not a development environment" unless Rails.env.development?

    @user = User.from_developer(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Developer") if is_navigational_format?
    else
      pp request.env["omniauth.auth"]
    end
  end

  def after_omniauth_failure_path_for(scope)
    root_path
  end
end

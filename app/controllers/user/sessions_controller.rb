# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  def destroy
    skip_authorization
    super
  end

  def respond_to_on_destroy
    redirect_to root_path
  end
end

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  after_action :verify_authorized, except: [:index, :show]
  after_action :verify_policy_scoped, only: [:index, :show]

  around_action :switch_time_zone

  def switch_time_zone(&block)
    time_zone = cookies["time_zone"]
    time_zone ||= current_user.time_zone if user_signed_in?
    time_zone ||= "UTC"

    if user_signed_in? && cookies["time_zone"] && cookies["time_zone"] != current_user.time_zone
      current_user.update(time_zone: cookies["time_zone"])
    end

    Time.use_zone(time_zone, &block)
  end
end

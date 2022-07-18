class ManageServerController < ApplicationController
  def index
    skip_policy_scope
    authorize :manage_server
  end

  def start
    authorize :manage_server

    puts "validating: #{params[:validate]}"

    ActionCable.server.broadcast(:manage_server_channel, {
      state: "started"
    })
  end

  def stop
    authorize :manage_server

    ActionCable.server.broadcast(:manage_server_channel, {
      state: "stopped"
    })
  end
end

class ManageServerController < ApplicationController
  def index
    skip_policy_scope
    authorize :manage_server

    @server_config = ServerConfig.last

    @selected_mission = @server_config.mission
    @missions = policy_scope(Mission).order(start: :desc).first(10)

    @selected_modlist = @server_config.modlist
    @modlists = policy_scope(Modlist).where.not(published_at: nil).order(created_at: :desc).first(10)
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

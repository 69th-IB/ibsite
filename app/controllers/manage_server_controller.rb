require "arma/server"

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

  def logs
    authorize :manage_server
    throw "server not started" if Arma::Server.instance.container.nil?

    render plain: Arma::Server.instance.container.logs(stdout: true, stderr: true)
  end

  def start
    authorize :manage_server

    Arma::Server.instance.start(params[:validate])
  end

  def stop
    authorize :manage_server

    Arma::Server.instance.stop
  end
end

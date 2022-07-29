class ServerConfigsController < ApplicationController
  def index
    @server_configs = policy_scope(ServerConfig).all
    respond_to do |format|
      # format.html
      format.json { render json: @server_configs }
    end
  end

  def edit
    @server_config = policy_scope(ServerConfig).find(params[:id])
    authorize @server_config
  end

  def show
    @server_config = policy_scope(ServerConfig).find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @server_config }
    end
  end

  def update
    @server_config = policy_scope(ServerConfig).find(params[:id])
    authorize @server_config

    @server_config.update(server_config_params)
  end

  private

  def server_config_params
    params.require(:server_config).permit(
      :title,
      :params, :branch, :creator_dlc, :maxfps, :headless_clients,
      :modlist_id, :mission_id,
      :body,
    )
  end
end

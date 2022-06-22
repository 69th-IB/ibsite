class MissionsController < ApplicationController
  def index
    @missions = Mission.all
  end

  def show
    @mission = Mission.includes(:squads, :slots).find(params[:id])

    return render 'not_found', status: 404 if @mission.nil?
  end
end

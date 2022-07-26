class MissionsController < ApplicationController
  def index
    @missions = policy_scope(Mission)
  end

  def show
    @mission = policy_scope(Mission).includes(:squads, :slots).find(params[:id])

    return render 'not_found', status: 404 if @mission.nil?
  end

  def new
    authorize Mission

    @mission = Mission.new
    set_default_hour
    @submit_url = missions_path
    @submit_method = :post
    render 'edit'
  end

  def create
    authorize Mission

    @mission = Mission.new(mission_params)
    @mission.creator = current_user

    if @mission.save
      redirect_to @mission
    else
      render 'new'
    end
  end

  def edit
    @mission = Mission.find(params[:id])
    authorize @mission

    set_default_hour
    @submit_url = mission_path(@mission)
    @submit_method = :patch
  end

  def update
    @mission = Mission.find(params[:id])
    authorize @mission

    if @mission.update(mission_params)
      redirect_to @mission
    else
      render 'edit'
    end
  end

  private

  def mission_params
    params.require(:mission).permit(:title, :start, :description, :pbo_file)
  end

  def set_default_hour
    default_time = nil
    Time.use_zone("US/Eastern") do
      default_time = Date.today + 16.hours
    end

    @default_hour = default_time.in_time_zone(Time.zone).hour
  end
end

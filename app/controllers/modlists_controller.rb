class ModlistsController < ApplicationController
  def index
    @modlists = policy_scope(Modlist).order(created_at: :desc)
  end

  def show
    @mission = policy_scope(Modlist).find(params[:id])

    return render 'not_found', status: 404 if @mission.nil?
  end

  def create
    authorize Modlist

    @modlist = Modlist.create(
      title: "New modlist",
      published: false,
      creator: current_user,
    )

    if @modlist.save
      redirect_to @modlist
    else
      redirect_to modlists_path
    end
  end

  def update
    authorize Modlist

    @modlist = Modlist.find(params[:id])
    @modlist.update(modlist_params)
  end

  def destroy
    authorize Modlist

    @modlist = Modlist.find(params[:id])
    @modlist.destroy
  end

  private

  def modlist_params
    params.require(:modlist).permit(:title, :published, :description)
  end
end

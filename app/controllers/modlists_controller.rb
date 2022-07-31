class ModlistsController < ApplicationController
  def index
    @modlists = policy_scope(Modlist).order(
      Arel.sql("published_at DESC NULLS FIRST"),
      created_at: :desc,
      created_at: :desc,
    )
  end

  def show
    @modlist = policy_scope(Modlist).find(params[:id])

    return render 'not_found', status: 404 if @modlist.nil?

    @mods = @modlist.mods.joins(:mod).order("mods.title")
  end

  def diff
    authorize Modlist

    @modlist = policy_scope(Modlist).find(params[:id])
    @other_modlist = policy_scope(Modlist).find(params[:other_id])

    return render 'not_found', status: 404 if @modlist.nil? or @other_modlist.nil?

    @mods = @modlist.mods.joins(:mod).order("mods.title").map(&:mod)
    @other_mods = @other_modlist.mods.joins(:mod).order("mods.title").map(&:mod)

    @added = @mods - @other_mods
    @removed = @other_mods - @mods
    @unchanged = @mods & @other_mods
  end

  def preset
    skip_authorization

    @modlist = policy_scope(Modlist).find(params[:id])
    @mods = @modlist.mods
      .joins(:mod)
      .order("mods.title")
      .where("optional = ? OR server_only = ?", false, true)
      .map(&:mod)

    render layout: nil
  end

  def create
    authorize Modlist

    @modlist = Modlist.create(
      title: "New modlist",
      published_at: nil,
      creator: current_user,
    )

    if @modlist.save
      redirect_to @modlist
    else
      redirect_to modlists_path
    end
  end

  def update
    @modlist = policy_scope(Modlist).find(params[:id])
    authorize @modlist

    if params[:mod_action].present?
      mod_action = params[:mod_action]
      @mod = @modlist.mods.find_by(id: params[:mod_id])

      if mod_action == "optional"
        @mod.update optional: params[:optional]
      elsif mod_action == "server_only"
        @mod.update server_only: params[:server_only]
      elsif mod_action == "remove"
        @mod.destroy
      elsif mod_action == "restore"
        mod = Mod.find(params[:mod_id])
        @modlist.mods.create(mod: mod)
      end
    elsif params[:workshop_id].present?
      workshop_id = params[:workshop_id]
      @modlist.add_by_workshop_id(workshop_id)
    else
      @modlist.update(modlist_params)
    end

    redirect_to @modlist
  end

  def publish
    @modlist = policy_scope(Modlist).find(params[:id])
    authorize @modlist

    @modlist.update(published_at: Time.now)
    redirect_to @modlist
  end

  def destroy
    @modlist = policy_scope(Modlist).find(params[:id])
    authorize @modlist

    @modlist.destroy
    redirect_to modlists_path
  end

  private

  def modlist_params
    params.require(:modlist).permit(:title, :description)
  end
end

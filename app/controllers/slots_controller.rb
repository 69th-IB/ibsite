class SlotsController < ApplicationController
  def enlist
    @slot = Slot.find(params[:id])
    authorize @slot

    unless @slot.user.nil?
      return unless current_user.can? :override_enlistment
    end

    @target_user = User.find(params[:user_id])
    return if @target_user.nil?

    if @target_user == current_user
      return unless current_user.can? :enlist_self
    else
      return unless current_user.can? :enlist_others
    end

    @slot.user = @target_user
    @slot.save
  end

  def unenlist
    @slot = Slot.find(params[:id])
    authorize @slot

    @target_user = @slot.user
    return if @target_user.nil?

    if @target_user == current_user
      return unless current_user.can? :enlist_self
    else
      return unless current_user.can? :enlist_others
    end

    @slot.user = nil
    @slot.save
  end
end

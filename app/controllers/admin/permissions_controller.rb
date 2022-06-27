class Admin::PermissionsController < ApplicationController
  before_action do
    authorize :admin
  end

  def index
    skip_policy_scope
    @roles = Discord::Role.includes(:permissions).order(position: :desc).all
    @permissions = Discord::RolePermission::PERMISSIONS
  end

  def grant
    Discord::RolePermission.create!(
      role_id: params[:role],
      key: params[:permission],
    )
  end

  def ungrant
    Discord::RolePermission.find_by!(
      role_id: params[:role],
      key: params[:permission],
    ).destroy
  end
end

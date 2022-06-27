class Admin::PermissionsController < ApplicationController
  def index
    @roles = Discord::Role.includes(:permissions).order(position: :desc).all
    @permissions = Discord::RolePermission::PERMISSIONS
  end
end

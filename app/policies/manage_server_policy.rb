class ManageServerPolicy < ApplicationPolicy
  def index?
    user&.can? :manage_server
  end

  def start?
    user&.can? :manage_server
  end

  def stop?
    user&.can? :manage_server
  end
end

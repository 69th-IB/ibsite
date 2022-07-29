class ServerConfigPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user&.can? :manage_server
        scope.all
      else
        scope.none
      end
    end
  end

  def edit?
    user&.can? :manage_server
  end

  def update?
    user&.can? :manage_server
  end
end

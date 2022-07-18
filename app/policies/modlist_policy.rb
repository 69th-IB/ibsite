class ModlistPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.can? :manage_modlists
  end

  def update?
    user.can? :manage_modlists
  end

  def destroy?
    user.can? :manage_modlists
  end
end

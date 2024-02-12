class ModlistPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user&.can? :manage_modlists
        scope.all
      else
        scope.where.not published_at: nil
      end
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def diff?
    show?
  end

  def create?
    user&.can? :manage_modlists
  end

  def update?
    user&.can?(:manage_modlists)
  end

  def publish?
    update? && record.mods.any? && !record.published?
  end

  def destroy?
    user&.can?(:manage_modlists)
  end
end

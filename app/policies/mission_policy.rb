class MissionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user&.can? :view_draft_missions then
        scope.all
      elsif user&.can? :view_missions_early then
        scope.where(draft: false)
      else
        scope.where(draft: false, public: true)
      end
    end
  end

  def index? = true
  def show? = true # rely on scope
  def create? = user&.can?(:create_missions)

  def update?
    return true if record.creator == user
    return true if user&.can? :modify_others_missions
    return false
  end

  def destroy?
    return true if user&.can? :delete_missions

    return true if record.creator == user && record.draft?

    false
  end
end

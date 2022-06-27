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
end

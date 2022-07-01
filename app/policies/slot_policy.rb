class SlotPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def enlist?
    mission = MissionPolicy::Scope.new(user, Mission).resolve.find(record.squad.mission_id)
    return false if mission.nil?

    # TODO: currently partially handled in controller because of self/others

    true
  end

  def unenlist?
    enlist?
  end
end

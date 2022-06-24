class Slot < ApplicationRecord
  belongs_to :squad
  belongs_to :user, optional: true

  after_update_commit do
    Turbo::StreamsChannel.broadcast_replace_later_to [ self.squad.mission, :squads ],
      target: self.squad,
      locals: { squad: self.squad },
      partial: "squads/squad"
  end
end

class Slot < ApplicationRecord
  belongs_to :squad
  belongs_to :user, optional: true

  broadcasts_to ->(slot) { [ slot.squad.mission ] }
end

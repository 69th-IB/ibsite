class Slot < ApplicationRecord
  belongs_to :squad
  belongs_to :user, optional: true
  delegate :mission, to: :squad

  broadcasts_to ->(slot) { [ slot.mission ] }
end

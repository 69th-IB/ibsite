class Slot < ApplicationRecord
  belongs_to :squad
  belongs_to :user, optional: true
end

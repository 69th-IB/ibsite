class Mission < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :squads, dependent: :destroy
  has_many :slots, through: :squads, dependent: :destroy

  has_rich_text :description

  def root_squads
    squads.where(parent_id: nil)
  end
end

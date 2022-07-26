class Mission < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :squads, dependent: :destroy
  has_many :slots, through: :squads, dependent: :destroy

  has_rich_text :description

  has_one_attached :pbo_file

  # can't be public if it's a draft
  validates :public, exclusion: { in: [true], if: :draft? }

  def root_squads
    squads.where(parent_id: nil)
  end
end

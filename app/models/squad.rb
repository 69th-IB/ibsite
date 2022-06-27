class Squad < ApplicationRecord
  belongs_to :mission
  belongs_to :parent, class_name: "Squad", optional: true

  has_many :slots, dependent: :destroy
  has_many :children, class_name: "Squad", foreign_key: :parent_id, dependent: :destroy

  # color must be empty or a valid hex color code (without the hash)
  validates :color, format: { with: /\A\z|\A[0-9A-F]{6}\z/i }

  broadcasts_to ->(squad) { [ squad.mission ] }
end

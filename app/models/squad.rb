class Squad < ApplicationRecord
  belongs_to :mission
  belongs_to :parent, class_name: "Squad", optional: true

  has_many :slots, dependent: :destroy
  has_many :children, class_name: "Squad", foreign_key: :parent_id, dependent: :destroy
end

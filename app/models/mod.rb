class Mod < ApplicationRecord
  has_and_belongs_to_many :modlists
  has_one_attached :thumbnail
end

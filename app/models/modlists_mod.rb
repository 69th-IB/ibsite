class ModlistsMod < ApplicationRecord
  belongs_to :modlist
  belongs_to :mod
  has_rich_text :notes
end

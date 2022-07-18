class Modlist < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_and_belongs_to_many :mods
  has_rich_text :description
end

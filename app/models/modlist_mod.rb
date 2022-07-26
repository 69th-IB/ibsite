class ModlistMod < ApplicationRecord
  belongs_to :modlist, dependent: :destroy
  belongs_to :mod, dependent: :destroy
  has_rich_text :notes

  def title = mod.title
  def workshop_id = mod.workshop_id
  def workshop_url = mod.workshop_url
  def file_size = mod.file_size
  def thumbnail = mod.thumbnail
end

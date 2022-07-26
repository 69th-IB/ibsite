require "steam/api"

class Modlist < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :mods, class_name: "ModlistMod", dependent: :destroy
  has_rich_text :description

  def published? = published_at.present?

  def add_by_workshop_id(id)
    if mods.joins(:mod).where("mod.workshop_id": id).exists?
      return false
    end

    details = Steam::API::PublishedFileService::get_details(id)

    if details.nil? || details["result"] != 1
      return false
    end

    mod = Mod.find_or_create_by(workshop_id: id)
    mod.title = details["title"]
    mod.file_size = details["file_size"].to_i
    mod.maybe_update_thumbnail(details["preview_url"])
    mod.save!

    assoc = ModlistMod.create(mod: mod)

    self.mods << assoc
    self.save!
  end
end

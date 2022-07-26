require "open-uri"

class Mod < ApplicationRecord
  has_many :modlist_mods
  has_many :modlists, through: :modlist_mods
  has_one_attached :thumbnail do |a|
    a.variant :thumb, resize_to_limit: [256, 256]
  end

  def workshop_url = "https://steamcommunity.com/sharedfiles/filedetails/?id=#{workshop_id}"

  def maybe_update_thumbnail(url)
    update_thumbnail(url) unless self.thumbnail.attached?
  end

  def update_thumbnail(url)
    self.thumbnail.attach(io: URI.open(url), filename: "thumbnail.png")
  end
end

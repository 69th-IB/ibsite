class User < ApplicationRecord
  # Include devise modules. Others available are:
  # :database_authenticatable, :recoverable, :confirmable, :lockable,
  # :timeoutable, :validatable, :trackable
  devise :registerable, :rememberable,
      :omniauthable, omniauth_providers: Rails.env.development? \
        ? [:discord, :steam, :developer]
        : [:discord, :steam]

  def self.from_discord(auth)
    where(discord_uid: auth.uid).first_or_create do |user|
      user.discord_name = auth.info.name
      user.discord_avatar_url = auth.info.image
      user.discord_discriminator = auth.extra.raw_info.discriminator
      user.discord_accent_color = auth.extra.raw_info.accent_color

      # if User is confirmable
      # user.skip_confirmation!
    end
  end

  def self.from_developer(auth)
    raise "not a development environment" unless Rails.env.development?

    where(discord_name: auth.info.name).first_or_create do |user|
      user.discord_uid = rand.to_s.split(".").last
      user.discord_avatar_url = "https://i.pravatar.cc/128?u=#{rand.to_s.split(".").last}"
      user.discord_discriminator = rand(9999).to_s.rjust(4, "0")
      user.discord_accent_color = rand(0xffffff)
    end
  end

  def display_name
    discord_name
  end
end

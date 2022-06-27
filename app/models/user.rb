class User < ApplicationRecord
  # Include devise modules. Others available are:
  # :database_authenticatable, :recoverable, :confirmable, :lockable,
  # :timeoutable, :validatable, :trackable
  devise :registerable, :rememberable,
      :omniauthable, omniauth_providers: Rails.env.development? \
        ? [:discord, :steam, :developer]
        : [:discord, :steam]

  has_and_belongs_to_many :roles,
    class_name: "Discord::Role",
    join_table: :discord_role_members

  has_many :permissions, through: :roles, class_name: "Discord::RolePermission"

  def admin? = roles.any? { |role| role.admin }
  def display_name = discord_nick || discord_name

  def color
    roles.order(position: :desc)
      .select { |role| role.color != nil }
      .first
      &.color || "808080"
  end

  def css_color(default = "inherit")
    return default if color.nil?
    "##{color}"
  end

  def can?(permission)
    admin? || permissions.any? { |p| p.key == permission.to_s }
  end

  def self.from_discord(auth)
    where(discord_uid: auth.uid).first_or_create do |user|
      user.discord_name = auth.info.name
      user.discord_avatar_url = auth.info.image
      user.discord_discriminator = auth.extra.raw_info.discriminator
      user.discord_accent_color = auth.extra.raw_info.accent_color

      user.discord_nick = Discord::Discord.instance.member_nick(auth.uid)
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
end

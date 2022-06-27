require "discord/discord"

class Discord::UpdateRolesJob < ApplicationJob
  queue_as :default

  def perform
    discord = Discord::Discord.instance

    ActiveRecord::Base.transaction do
      Discord::Role.delete_all

      discord.server.roles.each do |role|
        # discordrb is doodoo
        color = role.color.hex.rjust(6, "0") if role.color.combined != 0

        Discord::Role.create!(
          uid: role.id,
          name: role.name,
          color: color,
          position: role.position,
          admin: role.permissions.administrator,
        )
      end

      Discord::Role.connection.truncate :discord_role_members

      User.all.each do |user|
        roles = discord.member_roles(user.discord_uid)

        if roles.nil?
          Rails.logger.warn "No roles found for user #{user.discord_name}##{user.discord_discriminator} (#{user.id})"
        else
          roles.each do |role|
            user.roles << Discord::Role.find_by(uid: role.id)
          end
        end
      end
    end
  end
end

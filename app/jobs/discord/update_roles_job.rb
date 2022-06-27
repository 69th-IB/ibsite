require "discord/discord"

class Discord::UpdateRolesJob < ApplicationJob
  queue_as :default

  def perform
    discord = Discord::Discord.instance

    ActiveRecord::Base.transaction do
      newroles = discord.server.roles

      Discord::Role.where.not(uid: newroles.map(&:id)).destroy_all

      newroles.each do |role|
        # discordrb is doodoo
        color = role.color.hex.rjust(6, "0") if role.color.combined != 0

        record = {
          uid: role.id,
          name: role.name,
          color: color,
          position: role.position,
          admin: role.permissions.administrator,
        }

        Discord::Role.upsert(record, unique_by: :uid)
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

          user.update discord_nick: discord.member_nick(user.discord_uid)
        end
      end
    end
  end
end

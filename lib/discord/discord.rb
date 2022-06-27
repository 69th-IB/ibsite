class Discord::Discord
  include Singleton

  attr_reader :bot

  def initialize
    @bot = Discordrb::Bot.new(
      token: Rails.application.credentials.discord.bot_token,
    )

    @bot.run :async

    # we can make the changes directly instead of doing a full update, but
    # that's a bit harder than it seems because of eg. activerecord transactions

    @bot.server_role_create { Discord::UpdateRolesJob.perform_later }
    @bot.server_role_delete { Discord::UpdateRolesJob.perform_later }
    @bot.server_role_update { Discord::UpdateRolesJob.perform_later }

    @bot.member_join { Discord::UpdateRolesJob.perform_later }
    @bot.member_leave { Discord::UpdateRolesJob.perform_later }
    @bot.member_update { Discord::UpdateRolesJob.perform_later }
  end

  def server_id = Rails.application.credentials.discord.ib_server_id
  def server = @bot.server(server_id)
  def server_roles = server.roles
  def member_roles(uid) = server.member(uid)&.roles
  def member_nick(uid) = server.member(uid)&.nick
end
